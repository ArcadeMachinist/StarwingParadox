

class BurstMode {
    constructor() {
       // this.db = db;
        this.rooms = [];
        this.players = [];
        const protobuf = require("protobufjs");
        const root =  protobuf.loadSync("starwingMessage.proto");
        this.PMessage = root.lookupType("starwing.PbMessage");

        this.pbSendPayload = function(socket,payload) {
            let outMessage = this.PMessage.create(payload); // or use .fromObject if conversion is necessary
            let msgBuffer = this.PMessage.encode(outMessage).finish();
            let outBuffer = new Buffer.alloc(4+msgBuffer.byteLength);
            outBuffer.writeUInt32LE(msgBuffer.byteLength, 0);
            msgBuffer.copy(outBuffer,4);
            console.log("protoBuf Output --------------");
            console.log(outBuffer.toString('hex'));
            console.log("------------------------------");
            socket.write(outBuffer);
        }
        this.snooze = ms => new Promise(resolve => setTimeout(resolve, ms));
    }



    async RequestBurstGroupSelect (packetId, request)  {
        console.log("PlayerId      : "+request.PlayerId);
        console.log("MateId        : "+request.MateId);
        console.log(request.MateId);




        // locate joining player
        let joiner = new Object();
        for (let i = 0; i < this.players.length; i++) {
            if (this.players[i].PlayerId == request.PlayerId) joiner = this.players[i];
        }

        // locate room to join, update PlayerCount and push player into the room
        for (let i = 0; i < this.rooms.length; i++) {
            if (this.rooms[i].Player[0].PlayerId == parseInt(request.MateId)) {
                this.rooms[i].Player[0].MateNum++;
                this.rooms[i].Player.push(joiner);
            }
        }

        let payload = { packetId: packetId, messageType: 217, ResponseBurstGroupSelect: { MessageId: 1, Timeout: 100, Result: 0  } };
        // HERE RESULT 0: OK_Selected, 1: NG_NotFind
        this.pbSendPayload(joiner.socket, payload);

        // should also send NotifyBurstGroupApply to everyone in group
        let pbMessageRoot;
        let tRoomPlayers;
        for (let i = 0; i < this.rooms.length; i++) {
            if (this.rooms[i].Player[0].PlayerId == parseInt(request.MateId)) {
                let payload = { packetId: packetId, messageType: 308, NotifyBurstGroupApply : { Player: this.rooms[i].Player  } };
                let payload2 = { packetId: packetId, messageType: 307, NotifyBurstGroupUpdated : { Player: this.rooms[i].Player, StageId: 20001  } };

                for (let j = 0; j < this.rooms[i].Player.length; j++) {
                    let player = this.rooms[i].Player[j];
                    console.log("Sending update to player: "+player.PlayerId);

                    this.pbSendPayload(player.socket, payload);
                    this.snooze(10);
                    this.pbSendPayload(player.socket, payload2);
                }
                tRoomPlayers = this.rooms[i].Player;
            }
        }
//TODO this is temp code
        this.snooze(500);
        let payload2 = { packetId: 111, messageType: 310, NotifyBurstMade: {
                BurstGroupId: 1, BurstNum: 2, StageId: 20001,
                Player: tRoomPlayers
            }
        }
        console.log("Sending start to Player0 "+this.players[0].PlayerId);
        this.pbSendPayload(this.players[0].socket, payload2);
        console.log("Sending start to Player1 "+this.players[1].PlayerId);
        this.pbSendPayload(this.players[1].socket, payload2);

        payload2 = { packetId: 111, messageType: 311, NotifyBurstMeets: {
                BurstGroupId: 1, BurstNum: 2,
                Player: tRoomPlayers, State: 1
            }
        }
       // this.pbSendPayload(this.players[0].socket, payload2);


    }
    async RequestUpdateBurstGroup(packetId, request)  {   // aka ListRooms
        console.log("-- burstMode -- (RequestUpdateBurstGroup) --");
        //console.log(this.players);

        let pRooms = [];
        for (let i = 0; i < this.rooms.length; i++) {
            this.rooms[i].Player[0].Number=i+1;
            this.rooms[i].Player[0].MateNum=this.rooms[i].Player.length-1;
            pRooms.push(this.rooms[i].Player[0]);
        }

        let payload = { packetId: packetId, messageType: 215, ResponseUpdateBurstGroup: { MessageId: 5,
                Result: pRooms.length, Player: pRooms, Timeout: 300 } };
        return payload;

    }
    async RequestChangeBurstGroupMode(packetId,request) {   // aka CreateNewRoom
        console.log("-- burstMode -- (RequestChangeBurstGroupMode) --");
        console.log("PlayerId      : "+request.PlayerId);
        console.log("Mode          : "+request.Mode);
        if (typeof request.StageId != 'undefined')
            console.log("StageId       : "+request.StageId);
        console.log("------------------------------------------------");

        // Kill room if already exists
        this.rooms = this.rooms.filter(function(value, index, arr){
            if (typeof value.Player[0].PlayerId == 'undefined') return true;
            return value.Player[0].PlayerId !=  request.PlayerId;
        });

        // Get current player from saved data
        let roomOwner;
        for (let i = 0; i < this.players.length; i++) {
            console.log("This.Players[i], i="+i);
            console.log(this.players[i]);
            if (this.players[i].PlayerId == request.PlayerId) roomOwner = this.players[i];
        }


        let newRoom = {
            Player:[
                    roomOwner
            ],
            MessageId: 1,
            Result: 1
        };
        if (typeof request.StageId != 'undefined') newRoom.StageId = request.StageId;

        // No players  in the room except owner
        newRoom.Player[0].MateNum = 0;
        this.rooms.push(newRoom);

        for (let i = 0; i < this.rooms.length; i++) {
            if(this.rooms[i].Player[0].PlayerId == request.PlayerId) newRoom.Player[0].Number = i+1;
        }

        console.log("newRoom is");
        console.log(newRoom);

        let payload = { packetId: packetId, messageType: 211, ResponseChangeBurstGroupMode:  newRoom, Timeout: 100 };

        return payload;

    }
    async RequestEntryBurstGroup(packetId,request,socket) {   // aka register for coop
        console.log("-- burstMode -- (RequestEntryBurstGroup) --");
        console.log("( 1) PlayerId       : "+request.PlayerId);
        console.log("( 2) CardId         : "+request.CardId);
        console.log("( 3) MacAddress     : "+request.MacAddress.toString(16).padStart(12, '0').toUpperCase());
        console.log("( 4) Version        : "+request.Version);
        console.log("( 5) LocationId     : "+request.LocationId);
        console.log("( 6) LocationName   : "+request.LocationName);
        console.log("( 7) PlayMode       : "+request.PlayMode);
        console.log("( 8) Mode           : "+request.Mode);
        console.log("( 9) PlayerName     : "+request.PlayerName);
        console.log("(10) PlayerRank     : "+request.PlayerRank);
        console.log("(11) TitleId        : "+request.TitleId);
        console.log("(12) Emblem         : "+request.Emblem.pBg.PartId + "/"+request.Emblem.pMa.PartId+ "/" +request.Emblem.pSb.PartId);
        console.log("(13) BurstMode      : "+request.BurstMode);
        console.log("(14) Rank2on2       : "+request.Rank2on2);
        console.log("(15) TitleId2on2    : "+request.TitleId2on2);
        console.log("(16) Emblem2on2     : "+request.Emblem2on2.pBg.PartId + "/"+request.Emblem2on2.pMa.PartId+ "/" +request.Emblem2on2.pSb.PartId);
        console.log("(17) GameMode       : "+request.GameMode);
        console.log("-------------------------------------------");
        //console.log(request);
        //console.log(typeof request);

        let Player = new Object();
        Player.PlayerId = parseInt(request.PlayerId);
        Player.CardId = parseInt(request.CardId);
        Player.MacAddress = parseInt(request.MacAddress);
        Player.Version   =request.Version;
        Player.LocationId   =parseInt(request.LocationId);
        Player.LocationName  =request.LocationName;
        Player.PlayMode       =parseInt(request.PlayMode);
        Player.Mode           =parseInt(request.Mode);
        Player.PlayerName   =request.PlayerName;
        Player.PlayerRank   =parseInt(request.PlayerRank);
        Player.TitleId        =parseInt(request.TitleId);
        Player.Emblem      =request.Emblem;
        Player.BurstMode    =parseInt(request.BurstMode);
        Player.Rank2on2     =parseInt(request.Rank2on2);
        Player.TitleId2on2  =parseInt(request.TitleId2on2);
        Player.Emblem2on2   = request.Emblem2on2;
        Player.GameMode       = parseInt(request.GameMode);
        //console.log(Player);
        this.players = this.players.filter(function(value, index, arr){
            return value.PlayerId !=  Player.PlayerId;
        });
        Player.ts = new Date().getTime() / 1000;
        Player.socket = socket;
        this.players.push(Player);
//        console.log(this.players);
        let payload  = { packetId: packetId, messageType: 209, ResponseEntryBurstGroup: { MessageId: 1, Timeout: 120, BurstNumMax: 2  } }; // max players/room
        return  payload;
    }



}



exports.BurstMode = BurstMode;
