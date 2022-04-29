const fetch = require("node-fetch");
const express = require('express');
const protobuf = require("protobufjs");
const net = require('net');
const fs = require("fs");
const bodyParser = require('body-parser');
//const pg = require('pg');
const { Pool, Client } = require('pg');

const pp = require ("./starwing/playerProfile.js");
const br = require ("./starwing/battleRecorder.js");
const bm = require ("./starwing/burstMode.js");
let pbMessageRoot;


const snooze = ms => new Promise(resolve => setTimeout(resolve, ms));


const burstHandler = new bm.BurstMode();

protobuf.load("starwingMessage.proto", function(err, root) {
    if (err)
        throw err;
    pbMessageRoot = root;
})

const app = express();
const web_port = 4001;
const pb_port = 6666;

const matcher = "paradox.arcade.cab:"+pb_port;
const version_main = 70571;
const version_data = 70571;

let activeGameServers = [];
let playersWaitingMatch = [];

let cCounter = 0;

let authorizedClients = Array();

function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min) + min); //The maximum is exclusive and the minimum is inclusive
}


const pgdb = new Pool({
    user: 'paradox',
    host: 'localhost',
    database: 'paradox',
    password: 'XXXXXXX',
    port: 5432
});


app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies


function PbSendPayload(socket, payload) {
    let PMessage = pbMessageRoot.lookupType("starwing.PbMessage");

    errMsg = PMessage.verify(payload);
    if (errMsg)
        throw Error(errMsg);

    let outMessage = PMessage.create(payload); // or use .fromObject if conversion is necessary
    let msgBuffer = PMessage.encode(outMessage).finish();
    let outBuffer = new Buffer.alloc(4+msgBuffer.byteLength);
    outBuffer.writeUInt32LE(msgBuffer.byteLength, 0);
    msgBuffer.copy(outBuffer,4);
    console.log("protoBuf Outbut --------------");
    console.log(outBuffer.toString('hex'));
    console.log("------------------------------");
    socket.write(outBuffer);
}

net.createServer(socket => {

// Identify this client (GS)
    cCounter++;
    var connectionNumber = cCounter;
    socket.name = socket.remoteAddress + ":" + socket.remotePort

    if(authorizedClients. indexOf(socket.remoteAddress) !== -1){
        console.log("["+connectionNumber+"] Found client IP in authorized list");
        console.log("["+connectionNumber+"] Cabinet " + socket.name + " connected");
    } else {
        console.log("["+connectionNumber+"] Connection from " + socket.name + " not authorized");
//        console.log(authorizedClients);
        socket.destroy();
    }

    socket.on('data', async function(data) {
        var hexdata = new Buffer.from(data, 'ascii').toString('hex');
        console.log("[" + connectionNumber + "] RECEIVED: %s", hexdata);
        let recvBuffer = new Buffer.from(data, 'ascii');
        //console.log(recvBuffer.slice(0,1));
        let packetLen = recvBuffer.readUIntLE(0, 4);
        //console.log("[" + connectionNumber + "] SIZE: %d", packetLen);

        let incomingPB = recvBuffer.slice(4, 4+packetLen);
        console.log("[" + connectionNumber + "] ProtoBuf: %s", incomingPB.toString('hex'));

        let PMessage = pbMessageRoot.lookupType("starwing.PbMessage");
        let decoded = PMessage.decode(incomingPB);

        console.log("[" + connectionNumber + "] Decoded: %s", decoded);
        console.log("[" + connectionNumber + "] PacketId: "+decoded.packetId+" Type: "+decoded.messageType);

        let payload = {};
        let errMsg = null;
        let outMessage = null;
        let outBuffer;
        switch (parseInt(decoded.messageType)) {
            case 0x66: // ping!
                console.log("Processing message 0x66 (ping), TS:" + decoded.Ping.unixTimestamp);
                // reply!
                payload = { packetId: decoded.packetId, messageType: 0x67, Ping: { unixTimestamp: parseInt(Date.now()/1000)} };
                PbSendPayload(socket,payload);
                break;

            case 208:
                console.log("Processing message 208 (RequestEntryBurstGroup) aka register for coop");
                payload = await burstHandler.RequestEntryBurstGroup(decoded.packetId, decoded.RequestEntryBurstGroup, socket);
                PbSendPayload(socket,payload);
                break;

            case 216:
                console.log("Processing message 216 (RequestBurstGroupSelect) aka Select Room");
                payload = await burstHandler.RequestBurstGroupSelect(decoded.packetId, decoded.RequestBurstGroupSelect);
                //PbSendPayload(socket,payload);
                break;

            case 210:

                payload = await burstHandler.RequestChangeBurstGroupMode(decoded.packetId, decoded.RequestChangeBurstGroupMode);
                PbSendPayload(socket,payload);

                break;

                // TODO BURST!

                payload = { packetId: decoded.packetId, messageType: 310, NotifyBurstMade: {
                        BurstGroupId: 1, BurstNum: 2, StageId: 20001,
                        Player: [{
                            PlayerId: 10010,
                            MacAddress: 247207015480323,
                            CardId: 7020392000000000,
                            Number: 2,
                            PlayerName: "ArcadeMachinist",
                            PlayerRank: 20,
                            MateNum: 1,
                            LocationId: 77,
                            LocationName: "ZenGarden",
                            Rank2on2: 20,
                            TitleId: 1000001,
                            TitleId2on2: 100001
                        },
                            {
                                PlayerId: 10011,
                                MacAddress: 121375327350,
                                CardId: 7020392000000001,
                                Number: 2,
                                PlayerName: "LordCereth",
                                PlayerRank: 20,
                                MateNum: 1,
                                LocationId: 77,
                                LocationName: "ZenGarden",
                                Rank2on2: 20,
                                TitleId: 1000001,
                                TitleId2on2: 100001
                            }
                        ]
                        }
                }

                //PbSendPayload(socket,payload);

                payload = { packetId: decoded.packetId, messageType: 311, NotifyBurstMeets: {
                        State:1, BurstGroupId: 1, BurstNum: 2,
                        Player: [{
                            PlayerId: 10010,
                            MacAddress: 247207015480323,
                            CardId: 7020392000000000,
                            PlayerName: "ArcadeMachinist",
                            PlayerRank: 20,
                            BuddyId: 5,
                            LocationId: 77,
                            LocationName: "ZenGarden",
                            Intrude: false,
                            Rank2on2: 20,
                            BurstGroupId:1,
                            BurstNum:1
                            },
                            {
                                PlayerId: 10011,
                                MacAddress: 121375327351,
                                CardId: 7020392000000001,
                                PlayerName: "LordCereth",
                                PlayerRank: 20,
                                BuddyId: 1,
                                LocationId: 77,
                                LocationName: "ZenGarden",
                                Rank2on2: 20,
                                BurstGroupId: 1,
                                BurstNum: 1
                            }]
                        }};


                //PbSendPayload(socket,payload);
                break;
            case 214:
                console.log("Processing message 210 (RequestUpdateBurstGroup) aka ListRooms");
                payload = await burstHandler.RequestUpdateBurstGroup(decoded.packetId, decoded.RequestUpdateBurstGroup);
                PbSendPayload(socket,payload);
                break;

            case 200: // 100 yen mode
                console.log("Processing message 200 (RequestEntryMatching)");
                console.log("UserId       : "+decoded.RequestEntryMatching.UserId);
                console.log("CardId       : "+decoded.RequestEntryMatching.CardId);
                console.log("MacAddress   : "+decoded.RequestEntryMatching.MacAddress.toString(16).padStart(12, '0').toUpperCase());
                console.log("GameVersion  : "+decoded.RequestEntryMatching.GameVersion);
                console.log("LocationId   : "+decoded.RequestEntryMatching.LocationId);
                console.log("LocationName : "+decoded.RequestEntryMatching.LocationName);
                console.log("PlayMode     : "+decoded.RequestEntryMatching.PlayMode);

                payload = { packetId: decoded.packetId, messageType: 201, ResponseEntryMatching: { messageId: 1, timeout: 45 } };
                PbSendPayload(socket,payload);

                // send another fake msg
                payload = { packetId: parseInt(decoded.packetId)+1, messageType: 302, NotifyMatchMade:
                        { Match: {
                                Team:[{
                                    PlayerCount: 2,
                                    Player: [{
                                        PlayerId: 10010,
                                        MacAddress: 247207015480323,
                                        CardId: 7020392000000000,
                                        PlayerName: "ArcadeMachinist",
                                        PlayerRank: 20,
                                        BuddyId: 5,
                                        LocationId: 77,
                                        LocationName: "ZenGarden",
                                        Intrude: false,
                                        Rank2on2: 20
                                    },
                                        {
                                            PlayerId: 10011,
                                            MacAddress: 12346,
                                            CardId: 7020392000000001,
                                            PlayerName: "LordCereth",
                                            PlayerRank: 20,
                                            BuddyId: 2,
                                            LocationId: 77,
                                            LocationName: "ZenGarden",
                                            Rank2on2: 20
                                        }
                                    ]

                                }

                                ],
                                MatchId: 12345,
                                State: 1,
                                PlayMode: 101,
                                Difficulty: 0,
                                CoopModeIndex: 0,
                                MatchGroup: 0,
                                MatchMode: 0,
                                StageId: 20001,
                                Version: "70571",
                                VsCPU: true,
                                GameMode: 0
                            },
                            ds: { ServerId: 6789, State: 1, address: "192.168.0.55", version: "70571", language: "0" },
                            MatchType: 1,
                            GameMode: 0,
                            StageId: 20001
                        } };

                PbSendPayload(socket,payload);

                //payload = { packetId: decoded.packetId, messageType: 601, NotifyMatchOpen: { MatchId: 88888 } };
                //PbSendPayload(socket,payload);

                payload = { packetId: decoded.packetId, messageType: 304, NotifyMatchBegin: { MatchId: 12345 } };
                PbSendPayload(socket,payload);

                break;
            default:
                console.log("#################################");
                console.log("Unhandled ProtoBuf, ID: "+parseInt(decoded.messageType));
                console.log("#################################");

        }

    });
    socket.on('error', function (err) {
        if (err.code !== 'ECONNRESET') {
            // Ignore ECONNRESET and re throw anything else
//        throw err
            console.log("[" + connectionNumber + "] Socket ERROR !");
            //socket.end('Socket error!');
        }
    });
    socket.on('timeout',function(){
        console.log("[" + connectionNumber + "] Socket timed out !");
        socket.end('Timed out!');
        // can call socket.destroy() here too.
    })

    socket.on('end',function(data){
        console.log("[" + connectionNumber + "] Socket ended from other end!");
        console.log('End data : ' + data);
    })
    socket.on('close',function(error){
        var bread = socket.bytesRead;
        var bwrite = socket.bytesWritten;
        console.log("[" + connectionNumber + "] Bytes read : " + bread);
        console.log("[" + connectionNumber + "] Bytes written : " + bwrite);
        console.log("[" + connectionNumber + "] Socket closed!");

        activeGameServers  = activeGameServers.filter(function(value, index, arr){

            return value.connectionNumber != connectionNumber;

        });


        if(error){
            console.log("[" + connectionNumber + "] Socket was closed on transmission error");
        }
    })
    socket.on('connection', function (client) {
        console.log("[" + connectionNumber + "] Connected ", client)
    })
}).listen(pb_port,"0.0.0.0");


app.post('/matching/server', function (req, res, body) {

    console.log(req.path);
    console.log(req.headers);
    console.log(req.body);

    //let headers = JSON.parse(req.headers);
    if (req.header('x-galaxy-real-ip')) {
        if(authorizedClients. indexOf(req.header('x-galaxy-real-ip')) !== -1){
            console.log("Client IP " + req.header('x-galaxy-real-ip') + " already authorized");
        } else {
            console.log("Added Client IP " + req.header('x-galaxy-real-ip') + " to AcrProto authorization list");
            authorizedClients.push(req.header('x-galaxy-real-ip'));
        }
    }

    res.set('Content-type','application/json');
    res.set('x-galaxy-api', '*/*');
    //res.set('x-galaxy-api',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.send("{\n" +
        "\t\"ip_addr\": \"" + matcher + "\"\n" +
        "}");
    res.status(200).end();
});

app.post('/mock/matching/server', function (req, res, body) {

    console.log(req.path);
    console.log(req.headers);
    console.log(req.body);

    //let headers = JSON.parse(req.headers);

    res.set('Content-type','application/json');
    res.set('x-galaxy-api', '*/*');
    //res.set('x-galaxy-api',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.send("{\n" +
        "\t\"ip_addr\": \"" + matcher + "\"\n" +
        "}");
    res.status(200).end();
});

app.post('/mock/*', function (req, res, body) {

    console.log(req.path);
    console.log(req.headers);
    console.log('Body: '+JSON.stringify(req.body));

    //let headers = JSON.parse(req.headers);

    res.set('Content-type','application/json');
    res.set('x-galaxy-api', '*/*');
    //res.set('x-galaxy-api',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.send("{\n" +
        "\t\"ip_addr\": \"" + matcher + "\"\n" +
        "}");
    res.status(200).end();
});

app.post('/version', function (req, res, body) {

    console.log(req.path);
    console.log('Body: '+JSON.stringify(req.body));
    console.log(req.headers);


    //let headers = JSON.parse(req.headers);

    res.set('Content-type','application/json');
    res.set('x-galaxy-api', '*/*');
    //res.set('x-galaxy-api',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.send("{\n" +
        "\t\"client_version\": \"" + version_main + "\",\n" +
        "\t\"data_version\": \"" + version_data + "\",\n" +
        "\t\"stage_ids\": []"+
        "}");
    res.status(200).end();
});

app.post('/matching/match_id/generate', function (req, res) {
    console.log(req.path);
    console.log('Body: '+JSON.stringify(req.body));
    console.log(req.headers);
    res.set('Content-type','application/json');
    res.set('x-galaxy-api', '*/*');
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    let matchId = getRandomInt(10000,99999);
    res.send("{\"match_id\":"+matchId+"}");
    res.status(200).end();
});

app.post('/matching/*', function (req, res) {
    console.log(req.path);
    console.log('Body: '+JSON.stringify(req.body));
    console.log(req.headers);
    res.set('Content-type','application/json');
    res.set('x-galaxy-api', '*/*');
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.send("{}");
    res.status(200).end();
});

app.post('/ranking/*', function (req, res) {
    console.log(req.path);
    console.log('Body: '+JSON.stringify(req.body));
    console.log(req.headers);
    res.set('Content-type','application/json');
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    switch (req.path) {
        case "/ranking/national":
            res.set('x-galaxy-api', 'ranking/national');
            res.send(fs.readFileSync('starwing/c_rankingNational.json','utf8'));
            break;
        case "/ranking/location":
            res.set('x-galaxy-api', 'ranking/location');
            res.send(fs.readFileSync('starwing/c_rankingStore.json','utf8'));
            break;
        case "/ranking/prefecture":
            res.set('x-galaxy-api', 'ranking/prefecture');
            res.send(fs.readFileSync('starwing/c_rankingPrefecture.json','utf8'));
            break;
        case "/ranking/event":
            res.set('x-galaxy-api', 'ranking/event');
            res.send(fs.readFileSync('starwing/c_rankingEvent.json','utf8'));
            break;
        case "/ranking/weapon":
            res.set('x-galaxy-api', 'ranking/event');
            console.log("Weapon id: "+req.body.role_id);
            let jWeapons = JSON.parse(fs.readFileSync('starwing/c_rankingWeapon_r'+req.body.role_id+'.json','utf8'));
            jWeapons.role_id = req.body.role_id;
            res.send(JSON.stringify(jWeapons,null,4));
            break;
        deafult:
            res.set('x-galaxy-api', 'ranking/unknown');
            res.send("{}");
    }
    res.status(200).end();
});

app.post('/player/profile/load', async function (req, res, body) {

    console.log(req.path);
    console.log(req.headers);
    console.log('Body: '+JSON.stringify(req.body));

    //let headers = JSON.parse(req.headers);

    res.set('Content-type','application/json');
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api', 'player/profile');


    let pt = new pp.PlayerProfile();
    await pt.initWithNesys(pgdb,req.body.nesys_id);
    res.send(JSON.stringify(await pt.getProfile()));
//    res.send(fs.readFileSync('starwing/playerProfile.json','utf8'));
    res.status(200).end();

});

app.post('/player/login', async function (req, res, body) {

    console.log(req.path);
    console.log(req.headers);
    console.log('Body: '+JSON.stringify(req.body));

    //let headers = JSON.parse(req.headers);

    res.set('Content-type','application/json');
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api', 'player/login');

    let pt = new pp.PlayerProfile();
    console.log("PID:"+req.body.player_id);
    await pt.initWithPlayerID(pgdb,req.body.player_id);

    //console.log(pt.getPlayerID());

    res.send(JSON.stringify(await pt.playerLogin(req.header('x-galaxy-real-ip'),req.body)));
    //res.send(fs.readFileSync('starwing/playerLogin2.json','utf8'));
    res.status(200).end();

});


app.post('/player/login_bonus', async function (req, res, body) {

    console.log(req.path);
    console.log(req.headers);
    console.log('Body: '+JSON.stringify(req.body));

    //let headers = JSON.parse(req.headers);

    res.set('Content-type','application/json');
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api', 'player/login');


    res.send("{\n" +
        "\"result\": 1, " +
        "\"login_bonuses\": [],"+
        "\"update_items\": {}"+
        "}");
    res.status(200).end();

});


app.post('/player/register', async function (req, res, body) {

    console.log(req.path);
    console.log(req.headers);
    console.log('Body: '+JSON.stringify(req.body));
    res.set('Content-type','application/json');
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api', 'player/register');
    let pt = new pp.PlayerProfile();
    await pt.initWithPlayerID(pgdb,req.body.player_id);
    await pt.playerRegister(req.body);
//    res.send(JSON.stringify(await pt.playerRegister(req.body)));
    res.send("{\n" +
        "\"result\": 1" +
        "}");
    res.status(200).end();

});

app.post('/player/*', function (req, res, body) {

    console.log(req.path);
    console.log(req.headers);
    console.log('Body: '+JSON.stringify(req.body));

    //let headers = JSON.parse(req.headers);

    res.set('Content-type','application/json');
    res.set('x-galaxy-api', '*/*');
    //res.set('x-galaxy-api',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.send("{\n" +
        "\"result\": 1" +
        "}");
    res.status(200).end();
});


app.post('/mission/*', function (req, res, body) {


    //
    // mission/reward/get {"player_id":"10010","mission_id":"136001","mission_reward_ids":"[7102551]"}
    // waits for intimacy_reward_ids:[], update_items: {}, update_missions: []
    console.log(req.path);
    console.log(req.headers);
    console.log('Body: '+JSON.stringify(req.body));

    //let headers = JSON.parse(req.headers);

    res.set('Content-type','application/json');
    res.set('x-galaxy-api', '*/*');
    //res.set('x-galaxy-api',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.send("{\n" +
        "}");
    res.status(200).end();
})

app.post('/credit/*', function (req, res, body) {

    console.log(req.path);
    console.log(req.headers);
    console.log('Body: '+JSON.stringify(req.body));

    //let headers = JSON.parse(req.headers);

    res.set('Content-type','application/json');
    res.set('x-galaxy-api', '*/*');
    //res.set('x-galaxy-api',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.send("{\n" +
        "}");
    res.status(200).end();
})


app.post('/tutorial/*', function (req, res, body) {

    console.log(req.path);
    console.log(req.headers);
    console.log('Body: '+JSON.stringify(req.body));

    //let headers = JSON.parse(req.headers);

    res.set('Content-type','application/json');
    res.set('x-galaxy-api', '*/*');
    //res.set('x-galaxy-api',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.send("{\n" +
        "\"result\": 1" +
        "}");
    res.status(200).end();
});


app.post('/game_data/load/mission', async function (req, res, body) {
    // TODO no idea what comes here

    console.log(req.path);
    console.log(req.headers);
    console.log('Body: '+JSON.stringify(req.body));

    //let headers = JSON.parse(req.headers);

    res.set('Content-type','application/json');
    res.set('x-galaxy-api', '*/*');
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api', 'game_data/load');

    let pt = new pp.PlayerProfile();
    await pt.initWithPlayerID(pgdb,req.body.player_id);

    let pgd = await pt.playerLoadGameDataMissions();

    res.send(JSON.stringify(pgd,0,4));

    res.status(200).end();

});
app.post('/game_data/load', async function (req, res, body) {

    console.log(req.path);
    console.log(req.headers);
    console.log('Body: '+JSON.stringify(req.body));

    //let headers = JSON.parse(req.headers);

    res.set('Content-type','application/json');
    res.set('x-galaxy-api', '*/*');
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api', 'game_data/load');

    let pt = new pp.PlayerProfile();
    await pt.initWithPlayerID(pgdb,req.body.player_id);

    let pgd = await pt.playerLoadGameData();

    res.send(JSON.stringify(pgd,0,4));

    res.status(200).end();
});

app.post('/game_data/save', async function (req, res, body) {

    console.log(req.path);
    console.log(req.headers);
    console.log('Body: '+JSON.stringify(req.body));

    //let headers = JSON.parse(req.headers);

    res.set('Content-type','application/json');
    res.set('x-galaxy-api', 'game_data/save');
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));


    let pt = new pp.PlayerProfile();
    await pt.initWithPlayerID(pgdb,req.body.player_id);

    let gd = await pt.playerSaveGameData(req.body);

    res.send(JSON.stringify(gd,0,4));
    res.status(200).end();
});

app.post('/game_data/*', async function (req, res, body) {

    console.log(req.path);
    console.log(req.headers);
    console.log('Body: '+JSON.stringify(req.body));

    //let headers = JSON.parse(req.headers);

    res.set('Content-type','application/json');
    res.set('x-galaxy-api', '*/*');
    //res.set('x-galaxy-api',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.send("{\n" +
        "\"result\": 1" +
        "}");
    res.status(200).end();
});
app.post('/battle/record_2on2', async function (req, res, body) {

    console.log(req.path);
    console.log(req.headers);
    console.log('Body: '+JSON.stringify(req.body));

    //let headers = JSON.parse(req.headers);

    res.set('Content-type','application/json');
    res.set('x-galaxy-api', '*/*');
    //res.set('x-galaxy-api',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));


    let myBr = new br.BattleRecorder(pgdb);
    let response = await myBr.battleRecord2on2(req.body);

    res.send(JSON.stringify(response,0,4));

    res.status(200).end();
});

app.post('/battle/*', function (req, res, body) {

    console.log(req.path);
    console.log(req.headers);
    console.log('Body: '+JSON.stringify(req.body));

    //let headers = JSON.parse(req.headers);

    res.set('Content-type','application/json');
    res.set('x-galaxy-api', '*/*');
    //res.set('x-galaxy-api',req.header('x-galaxy-api-id'));
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.send("{\n" +
        "\"result\": 1" +
        "}");
    res.status(200).end();
});

app.post('/resource', function (req, res) {
    console.log(req.path);
    console.log('Body: '+JSON.stringify(req.body));
    console.log(req.headers);
    res.set('Content-type','application/json');
    res.set('x-galaxy-api', '*/*');
    res.set('x-galaxy-api-id',req.header('x-galaxy-api-id'));
    res.send(fs.readFileSync('starwing/c_resource.json','utf8'));

    res.status(200).end();
});

app.listen(web_port, () => {
    console.log(`StarWing Paradox prototype GameServer`);
    console.log(`HTTP ${web_port} Protobuf ${pb_port}`);
})

