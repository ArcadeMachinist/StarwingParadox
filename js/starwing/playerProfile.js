
class PlayerProfile {
    constructor() {
        this.db = null;
    }
    async initWithPlayerID(db, player_id) {
        this.Player = {};
        this.Player.player_id = player_id;
        this.db = db;
        if (player_id == 0 || player_id === null || typeof player_id == 'undefined') {
            // TODO sanity checks on nesys_id
            return false;
        } else {

            const qtext = 'SELECT * FROM player WHERE player_id=$1';
            let res = await db.query(qtext, [player_id]);
            if (res.rows.length  == 0) {

                return false;
            } else {
                for(var k in res.rows[0]) this.Player[k]=res.rows[0][k];
            }

        }
    }
    async initWithNesys(db, nesys_id) {
        this.Player = {};
        this.db = db;
        if (nesys_id == 0 || nesys_id === null || typeof nesys_id == 'undefined') {
            // TODO sanity checks on nesys_id
            return false;
        } else {
            this.Player.nesys_id = nesys_id;
            //console.log(this.Player);
            const qtext = 'SELECT * FROM player WHERE nesys_id=$1';
            try {
                let res = await db.query(qtext, [this.Player.nesys_id]);

                if (res.rows.length  == 0) {
                    // Create
                    const qtext = 'INSERT INTO player(nesys_id) VALUES ($1) RETURNING player_id';
                    try {
                        let res = await db.query(qtext, [this.Player.nesys_id]);
                        let newPlayerId = res.rows[0].player_id;
                        if (newPlayerId) {
                            //let newPlayerId = res.rows[0].player_id;
                            const qtext = 'SELECT * FROM player WHERE player_id=$1';
                            let res = await db.query(qtext, [newPlayerId]);
                            if (res.rows.length  == 0) {
                                throw "Get new playerID failed (2)";
                            } else {
                                for(var k in res.rows[0]) this.Player[k]=res.rows[0][k];
                            }
                        } else {
                            throw "Get new playerID failed (1)";
                        }
                    } catch(err) {
                        console.log(err.stack);
                    }

                } else {
                    for(var k in res.rows[0]) this.Player[k]=res.rows[0][k];

                }

            } catch (err) {
                console.log(err.stack);
            }
        }


        return true;
    }
    async playerLoadGameDataMissions() {
        if (this.Player.player_id){
            let gameData = new Object();
            let qtext = "SELECT mission_id,clear_count,clear_num,status,mission_status FROM player_missions WHERE player_id=$1";
            let res = await this.db.query(qtext, [this.Player.player_id]);
            gameData.missions = [];
            for(let k in res.rows) {
                gameData.missions.push(res.rows[k]);

            }
            return gameData;
        }
    }
    async playerLoadGameData() {

        if (this.Player.player_id){

            let gameData = new Object();


            let qtext = "SELECT COUNT(id) AS same_day_login_count FROM player_logins WHERE date_trunc('day', ts_when) = $1 AND player_id=$2";
            let res = await this.db.query(qtext, [new Date().toISOString().substring(0,10) , this.Player.player_id]);
            this.Player.same_day_login_count = parseInt(res.rows[0].same_day_login_count);

            // Get stat values - total_login_days
            qtext = "SELECT COUNT(DISTINCT(date_trunc('day', ts_when))) AS total_login_days FROM player_logins WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            this.Player.total_login_days = parseInt(res.rows[0].total_login_days);

            // Get stat values - consecutive_login_days FAKED TODO SQL count
            this.Player.consecutive_login_days = this.Player.same_day_login_count ? 1 : 0;
            this.Player.last_pref_ranking_order_id = 0;
            this.Player.pref_ranking_top_player_count = 0;
            this.Player.official_player_type_id = 0;

            gameData.player = this.Player;

            qtext = "SELECT buddy_id, buddy_key, buddy_value FROM player_buddies WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            gameData.buddies = [];
            for(let k in res.rows) {
                if (typeof gameData.buddies[res.rows[k].buddy_id] == 'undefined') {
                    gameData.buddies[res.rows[k].buddy_id] = new Object();
                    gameData.buddies[res.rows[k].buddy_id]["buddy_id"] = res.rows[k].buddy_id;
                }
                gameData.buddies[res.rows[k].buddy_id][res.rows[k].buddy_key] = res.rows[k].buddy_value;
            }


            // Filter-out empty buddy #0


            gameData.buddies = gameData.buddies.filter(value => Object.keys(value).length !== 0);

            //console.log(JSON.stringify(this.Player.buddies));

            qtext = "SELECT progress_key,status FROM player_progress WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            gameData.progresses = [];
            for(let k in res.rows) {
                gameData.progresses.push(res.rows[k]);
            }

            qtext = "SELECT option_key,value_num FROM player_options WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            gameData.options = [];
            for(let k in res.rows) {
                gameData.options.push(res.rows[k]);
            }

            qtext = "SELECT mission_id,clear_count,clear_num,status,mission_status FROM player_missions WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            gameData.missions = [];
            for(let k in res.rows) {
                gameData.missions.push(res.rows[k]);
            }

            gameData.buddy_skills = []; // TODO

            gameData.buddy_win_poses = [];
            qtext = "SELECT * FROM player_buddy_win_poses WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            for(let k in res.rows) {
                delete res.rows[k].id;
                delete res.rows[k].player_id;
                gameData.buddy_win_poses.push(res.rows[k]);
            }

            gameData.emblems = [];
            qtext = "SELECT * FROM player_emblems WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            for(let k in res.rows) {
                delete res.rows[k].id;
                delete res.rows[k].player_id;
                let emblem = new Object();
                emblem.emblem_id = res.rows[k].emblem_id;
                emblem.outline = new Object();
                emblem.outline.part_id = res.rows[k].outline_part_id;
                emblem.outline.offset = [res.rows[k].outline_offset_x, res.rows[k].outline_offset_y];
                emblem.outline.scale = [res.rows[k].outline_scale_x, res.rows[k].outline_scale_y];
                emblem.outline.angle = res.rows[k].outline_angle;
                emblem.main_design = new Object();
                emblem.main_design.part_id = res.rows[k].main_design_part_id;
                emblem.main_design.offset = [res.rows[k].main_design_offset_x, res.rows[k].main_design_offset_y];
                emblem.main_design.scale = [res.rows[k].main_design_scale_x, res.rows[k].main_design_scale_y];
                emblem.main_design.angle = res.rows[k].main_design_angle;
                emblem.sub_design = new Object();
                emblem.sub_design.part_id = res.rows[k].sub_design_part_id;
                emblem.sub_design.offset = [res.rows[k].sub_design_offset_x, res.rows[k].sub_design_offset_y];
                emblem.sub_design.scale = [res.rows[k].sub_design_scale_x, res.rows[k].sub_design_scale_y];
                emblem.sub_design.angle = res.rows[k].sub_design_angle;
                emblem.status = res.rows[k].status;
                emblem.editable = res.rows[k].editable;
                gameData.emblems.push(emblem);
            }

            gameData.emblem_parts = [];
            qtext = "SELECT * FROM player_emblem_parts WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            for(let k in res.rows) {
                delete res.rows[k].id;
                delete res.rows[k].player_id;
                gameData.emblem_parts.push(res.rows[k]);
            }

            //gameData.mecha_preset_parts = []; // TODO
            //gameData.mecha_presets = [];
            //gameData.mecha_parts = [];

            //gameData.weapon_roles = [];
            //gameData.weapon_role_presets = [];
            //gameData.weapon_role_preset_slots = [];
            //gameData.weapons = [];

            //gameData.symbol_chats = [];
            //gameData.symbol_chat_slots = [];

            gameData.titles = [];
            qtext = "SELECT * FROM player_titles WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            for(let k in res.rows) {
                delete res.rows[k].id;
                delete res.rows[k].player_id;
                gameData.titles.push(res.rows[k]);
            }

            gameData.line_colors = [];
            qtext = "SELECT * FROM player_line_colors WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            for(let k in res.rows) {
                delete res.rows[k].id;
                delete res.rows[k].player_id;
                gameData.line_colors.push(res.rows[k]);
            }

            //gameData.cockpit_items = [];  // TODO
            //gameData.present_items = [];
            //gameData.greetings = [];
            //gameData.buddy_greetings = [];
            //gameData.game_moneys = [];
            //gameData.quests = [];

            gameData.mecha_sets = [];
            qtext = "SELECT * FROM player_mecha_sets WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            for(let k in res.rows) {
                delete res.rows[k].id;
                delete res.rows[k].player_id;
                gameData.mecha_sets.push(res.rows[k]);
            }

            gameData.mecha_set_parts = [];
            qtext = "SELECT * FROM player_mecha_set_parts WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            for(let k in res.rows) {
                delete res.rows[k].id;
                delete res.rows[k].player_id;
                gameData.mecha_set_parts.push(res.rows[k]);
            }

            gameData.mecha_colors = [];
            qtext = "SELECT * FROM player_mecha_colors WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            for(let k in res.rows) {
                delete res.rows[k].id;
                delete res.rows[k].player_id;
                gameData.mecha_colors.push(res.rows[k]);
            }

            gameData.weapon_set = [];
            qtext = "SELECT * FROM player_weapon_set WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            for(let k in res.rows) {
                delete res.rows[k].id;
                delete res.rows[k].player_id;
                gameData.weapon_set.push(res.rows[k]);
            }

            gameData.weapon_set_slots = [];
            qtext = "SELECT * FROM player_weapon_set_slots WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            for(let k in res.rows) {
                delete res.rows[k].id;
                delete res.rows[k].player_id;
                gameData.weapon_set_slots.push(res.rows[k]);
            }

            gameData.side_weapons = [];
            qtext = "SELECT * FROM player_side_weapons WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            for(let k in res.rows) {
                delete res.rows[k].id;
                delete res.rows[k].player_id;
                gameData.side_weapons.push(res.rows[k]);
            }

            gameData.violation_point = 0;
            gameData.winning_streaks_2on2 = 1;

            return gameData;
        }
        return false;
    }
    async getProfile() {
        if (this.Player.player_id){

            // Get stat values - same_day_login_count
            let qtext = "SELECT COUNT(id) AS same_day_login_count FROM player_logins WHERE date_trunc('day', ts_when) = $1 AND player_id=$2";
            let res = await this.db.query(qtext, [new Date().toISOString().substring(0,10) , this.Player.player_id]);
            this.Player.same_day_login_count = parseInt(res.rows[0].same_day_login_count);

            // Get stat values - total_login_days
            qtext = "SELECT COUNT(DISTINCT(date_trunc('day', ts_when))) AS total_login_days FROM player_logins WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            this.Player.total_login_days = parseInt(res.rows[0].total_login_days);

            // Get stat values - consecutive_login_days FAKED TODO SQL count
            this.Player.consecutive_login_days = this.Player.same_day_login_count ? 1 : 0;

            // Emblem, TODO separatetable
            this.Player.emblem = new Object();
            this.Player.emblem.outline = new Object();
            this.Player.emblem.outline.part_id = 0;
            this.Player.emblem.outline.offset = [0,0];
            this.Player.emblem.outline.scale = [1,1];
            this.Player.emblem.outline.angle = 0;
            this.Player.emblem.main_design = new Object();
            this.Player.emblem.main_design.part_id = 0;
            this.Player.emblem.main_design.offset = [0,0];
            this.Player.emblem.main_design.scale = [1,1];
            this.Player.emblem.main_design.angle = 0;
            this.Player.emblem.sub_design = new Object();
            this.Player.emblem.sub_design.part_id = 0;
            this.Player.emblem.sub_design.offset = [0,0];
            this.Player.emblem.sub_design.scale = [1,1];
            this.Player.emblem.sub_design.angle = 0;

            qtext = "SELECT progress_key,status FROM player_progress WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            this.Player.progresses = [];

            let progress = new Object();
            for(let k in res.rows) {
                this.Player.progresses.push(res.rows[k]);
            }

            this.Player.last_pref_ranking_order_id = 0;
            this.Player.pref_ranking_top_player_count = 0;
            this.Player.official_player_type_id = 0;



            return this.Player;
        } else {
            return false;
        }
    }
    async playerLogin (ip_addr,req_body) {
        if (this.Player.player_id) {
            let qtext = "INSERT INTO player_logins (player_id,ip_addr,ts_when,location_id,client_version,data_version) VALUES ($1,$2,now(),$3,$4,$5)";
            let res = await this.db.query(qtext, [this.Player.player_id,ip_addr,req_body.location_id,req_body.client_version,req_body.data_version]);
            let Login = this.Player;

            Login.progresses = [];
            qtext = "SELECT progress_key,status FROM player_progress WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            let progress = new Object();
            for(let k in res.rows) {
                Login.progresses.push(res.rows[k]);
            }

            Login.greeting_ids = [1];
            Login.battle_count = 3; // TODO number of matches played

            qtext = "SELECT COUNT(id) AS same_day_login_count FROM player_logins WHERE date_trunc('day', ts_when) = $1 AND player_id=$2";
            res = await this.db.query(qtext, [new Date().toISOString().substring(0,10) , this.Player.player_id]);
            Login.same_day_login_count = parseInt(res.rows[0].same_day_login_count);

            // Get stat values - total_login_days
            qtext = "SELECT COUNT(DISTINCT(date_trunc('day', ts_when))) AS total_login_days FROM player_logins WHERE player_id=$1";
            res = await this.db.query(qtext, [this.Player.player_id]);
            Login.total_login_days = parseInt(res.rows[0].total_login_days);

            // Get stat values - consecutive_login_days FAKED TODO SQL count
            Login.consecutive_login_days = Login.same_day_login_count ? 1 : 0;

            Login.burst_match = false;
            Login.next_burst_begin = "";
            Login.next_burst_end = "";

            Login.open_boss_matches = [20001]; // array of int
            Login.next_boss_matches = [20002];

            return Login;
        } else {
            return false;
        }

    }

    async playerRegister (req_body) {

        if (this.Player.player_id) {
            let progresses = new Object();
            progresses = req_body.progresses;
            delete req_body.progresses;
            delete req_body.player_id;

            let qvars = [];
            let qtext = "UPDATE player SET ";
            let p=1;
            for(let k in req_body) {
                if (p>1) qtext += ", ";
                qtext += k + "=$"+p;
                p++;
                qvars.push(req_body[k]);
            }
            qtext += " WHERE player_id=$"+p;
            qvars.push(this.Player.player_id);

            let res = await this.db.query(qtext, qvars);
//            console.log(qtext);
//            console.log(qvars);


            // TODO process progress too!
            console.log(progresses);
            progresses = JSON.parse(progresses);
            for(let k in progresses) {
                //console.log(progresses[k]);
                //console.log(progresses[k].progress_key);
                qtext = "INSERT INTO player_progress (player_id, progress_key, status) " +
                    "VALUES ($1, $2, $3) " +
                    "ON CONFLICT (player_id,progress_key) DO UPDATE " +
                    "  SET status = excluded.status";
                qvars = [this.Player.player_id,progresses[k].progress_key,progresses[k].status];
                res = await this.db.query(qtext, qvars);
            }
            //es = await this.db.query(qtext, qvars);
        } else {
            return false;
        }
    }

    async playerSaveGameData (req_body) {
        let gameData = new Object(); // that's our reply
        for(let j in req_body) {
            console.log("Processing: "+j);
            if (j == "options") {
                let options = JSON.parse(req_body[j]);
                for( let k in options) {
                    let qtext = "INSERT INTO player_options (player_id, option_key, value_num) " +
                        "VALUES ($1, $2, $3) " +
                        "ON CONFLICT (player_id,option_key) DO UPDATE " +
                        "  SET value_num = excluded.value_num";
                    let qvars = [this.Player.player_id,options[k].option_key,options[k].value_num];
                    let res = await this.db.query(qtext, qvars);
                }
            } else if (j == "buddies") {
                //console.log(req_body[j]);
                let buddies = JSON.parse(req_body[j]);
                for( let k in buddies) {
                    let buddy = buddies[k];
                    let buddy_id = buddies[k].buddy_id;
                    delete buddies[k].buddy_id;
                    for (const [key, value] of Object.entries(buddy)) {
//                        console.log(`${key}: ${value}`);
//                        console.log("=======");
                        let qtext = "INSERT INTO player_buddies (player_id, buddy_id, buddy_key, buddy_value) " +
                            "VALUES ($1, $2, $3, $4) " +
                            "ON CONFLICT (player_id,buddy_id,buddy_key) DO UPDATE " +
                            "  SET buddy_value = excluded.buddy_value";
                        let qvars = [this.Player.player_id,buddy_id,key,value];
                        let res = await this.db.query(qtext, qvars);
                    }

                        /*
                        let qtext = "INSERT INTO player_buddies (player_id, buddy_id, buddy_key, buddy_value) " +
                            "VALUES ($1, $2, $3, $4) " +
                            "ON CONFLICT (player_id,budy_id,buddy_key) DO UPDATE " +
                            "  SET buddy_value = excluded.buddy_value";
                        let qvars = [this.Player.player_id,buddies[k][kk],buddies[k].value_num];
                        *
                         */

                    //let res = await this.db.query(qtext, qvars);
                }
            } else if (j == "progresses") {
                let progresses = JSON.parse(req_body[j]);
                for(let k in progresses) {
                    //console.log(progresses[k]);
                    //console.log(progresses[k].progress_key);
                    let qtext = "INSERT INTO player_progress (player_id, progress_key, status) " +
                        "VALUES ($1, $2, $3) " +
                        "ON CONFLICT (player_id,progress_key) DO UPDATE " +
                        "  SET status = excluded.status";
                    let qvars = [this.Player.player_id,progresses[k].progress_key,progresses[k].status];
                    let res = await this.db.query(qtext, qvars);
                }
            } else if (j == "missions") {
                let missions = JSON.parse(req_body[j]);
                for(let k in missions) {
                    let qtext = "INSERT INTO player_missions (player_id, mission_id, clear_count, clear_num,  status, mission_status) " +
                        "VALUES ($1, $2, $3, $4, $5, $6) " +
                        "ON CONFLICT (player_id,mission_id) DO UPDATE " +
                        "  SET clear_count = excluded.clear_count, clear_num=excluded.clear_num, status=excluded.status, mission_status=excluded.mission_status";
                    let qvars = [this.Player.player_id,missions[k].mission_id,missions[k].clear_count,missions[k].clear_num,missions[k].status,missions[k].mission_status];
                    let res = await this.db.query(qtext, qvars);
                }
            } else if (j == "titles") {
                let save_data = JSON.parse(req_body[j]);
                for(let k in save_data) {
                    let qtext = "INSERT INTO player_titles (player_id, title_id,  status) " +
                        "VALUES ($1, $2, $3) " +
                        "ON CONFLICT (player_id,title_id) DO UPDATE " +
                        "  SET status = excluded.status";
                    let qvars = [this.Player.player_id,save_data[k].title_id,save_data[k].status];
                    let res = await this.db.query(qtext, qvars);
                }
            } else if (j == "emblems") {
                let save_data = JSON.parse(req_body[j]);
                for(let k in save_data) {
                    let qtext = "INSERT INTO player_emblems (player_id, emblem_id,  " +
                        "  outline_part_id, outline_offset_x, outline_offset_y, outline_scale_x, outline_scale_y, outline_angle, " +
                        "  main_design_part_id, main_design_offset_x, main_design_offset_y, main_design_scale_x, main_design_scale_y, main_design_angle, " +
                        "  sub_design_part_id, sub_design_offset_x, sub_design_offset_y, sub_design_scale_x, sub_design_scale_y, sub_design_angle, " +
                        "  status, editable)" +
                        " VALUES ($1, $2, " +
                        "$3,$4,$5,$6,$7,$8," +
                        "$9,$10,$11,$12,$13,$14," +
                        "$15,$16,$17,$18,$19,$20," +
                        "$21,$22" +
                        ") ON CONFLICT (player_id,emblem_id) DO UPDATE " +
                        " SET outline_part_id = excluded.outline_part_id, outline_offset_x = excluded.outline_offset_x, outline_offset_y = excluded.outline_offset_y ," +
                        " outline_scale_x = excluded.outline_scale_x, outline_scale_y = excluded.outline_scale_y, outline_angle = excluded.outline_angle," +
                        " main_design_part_id = excluded.main_design_part_id, main_design_offset_x = excluded.main_design_offset_x, main_design_offset_y = excluded.main_design_offset_y, " +
                        " main_design_scale_x = excluded.main_design_scale_x, main_design_scale_y = excluded.main_design_scale_y, main_design_angle = excluded.main_design_angle, " +
                        " sub_design_part_id = excluded.sub_design_part_id, sub_design_offset_x = excluded.sub_design_offset_x, sub_design_offset_y = excluded.sub_design_offset_y, " +
                        " sub_design_scale_x = excluded.sub_design_scale_x, sub_design_scale_y = excluded.sub_design_scale_y, sub_design_angle = excluded.sub_design_angle," +
                        " status = excluded.status, editable = excluded.editable";
                    let qvars = [this.Player.player_id,
                        save_data[k].emblem_id,
                        save_data[k].outline.part_id,
                        save_data[k].outline.offset[0],
                        save_data[k].outline.offset[1],
                        save_data[k].outline.scale[0],
                        save_data[k].outline.scale[1],
                        save_data[k].outline.angle,
                        save_data[k].main_design.part_id,
                        save_data[k].main_design.offset[0],
                        save_data[k].main_design.offset[1],
                        save_data[k].main_design.scale[0],
                        save_data[k].main_design.scale[1],
                        save_data[k].main_design.angle,
                        save_data[k].sub_design.part_id,
                        save_data[k].sub_design.offset[0],
                        save_data[k].sub_design.offset[1],
                        save_data[k].sub_design.scale[0],
                        save_data[k].sub_design.scale[1],
                        save_data[k].sub_design.angle,
                        save_data[k].status,
                        save_data[k].editable
                    ];
                    let res = await this.db.query(qtext, qvars);
                }
            }  else if (j == "emblem_parts") {
                let save_data = JSON.parse(req_body[j]);
                for(let k in save_data) {
                    let qtext = "INSERT INTO player_emblem_parts (player_id, part_id,  status) " +
                        "VALUES ($1, $2, $3) " +
                        "ON CONFLICT (player_id,part_id) DO UPDATE " +
                        "  SET status = excluded.status";
                    let qvars = [this.Player.player_id,save_data[k].part_id,save_data[k].status];
                    let res = await this.db.query(qtext, qvars);
                }
            } else if (j == "mecha_sets") {

                let save_data = JSON.parse(req_body[j]);
                for(let k in save_data) {
                    let qtext = "INSERT INTO player_mecha_sets (player_id, mecha_set_id, mecha_setbonus_id, weapon_set_id, is_decal, favorite, use_count, use_time, status, win_count, winning_streaks) " +
                        "VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) " +
                        "ON CONFLICT (player_id,mecha_set_id) DO UPDATE " +
                        "SET mecha_setbonus_id = excluded.mecha_setbonus_id," +
                        "weapon_set_id = excluded.weapon_set_id, is_decal = excluded.is_decal, favorite = excluded.favorite, " +
                        "use_count = excluded.use_count, use_time = excluded.use_time, status = excluded.status, win_count = excluded.win_count, winning_streaks = excluded.winning_streaks";
                    let qvars = [this.Player.player_id,save_data[k].mecha_set_id,save_data[k].mecha_setbonus_id,
                        save_data[k].weapon_set_id,save_data[k].is_decal,save_data[k].favorite,
                        save_data[k].use_count,save_data[k].use_time,save_data[k].status,save_data[k].win_count,save_data[k].winning_streaks];
                    let res = await this.db.query(qtext, qvars);
                }
            } else if (j == "mecha_set_parts") {

                let save_data = JSON.parse(req_body[j]);
                for(let k in save_data) {
                    let qtext = "INSERT INTO player_mecha_set_parts (player_id, mecha_set_id, part_id, mecha_id, design_id, color_id) " +
                        "VALUES ($1, $2, $3, $4, $5, $6) " +
                        "ON CONFLICT (player_id,mecha_set_id,part_id) DO UPDATE " +
                        "SET mecha_id = excluded.mecha_id," +
                        "design_id = excluded.design_id, color_id = excluded.color_id";
                    let qvars = [this.Player.player_id,save_data[k].mecha_set_id,save_data[k].part_id,
                        save_data[k].mecha_id,save_data[k].design_id,save_data[k].color_id];
                    let res = await this.db.query(qtext, qvars);
                }
            } else if (j == "buddy_win_poses") {


                let save_data = JSON.parse(req_body[j]);
                for(let k in save_data) {
                    let qtext = "INSERT INTO player_buddy_win_poses (player_id, buddy_id, win_pose_id, status) " +
                        "VALUES ($1, $2, $3, $4) " +
                        "ON CONFLICT (player_id, buddy_id, win_pose_id) DO UPDATE " +
                        "  SET status = excluded.status";
                    let qvars = [this.Player.player_id,save_data[k].buddy_id,save_data[k].win_pose_id,save_data[k].status];
                    let res = await this.db.query(qtext, qvars);
                }
            } else if (j == "line_colors") {

                let save_data = JSON.parse(req_body[j]);
                for(let k in save_data) {
                    let qtext = "INSERT INTO player_line_colors (player_id, line_color_id, status) " +
                        "VALUES ($1, $2, $3) " +
                        "ON CONFLICT (player_id, line_color_id) DO UPDATE " +
                        "  SET status = excluded.status";
                    let qvars = [this.Player.player_id,save_data[k].line_color_id,save_data[k].status];
                    let res = await this.db.query(qtext, qvars);
                }
            } else if (j == "mecha_colors") {
                let save_data = JSON.parse(req_body[j]);
                for(let k in save_data) {
                    let qtext = "INSERT INTO player_mecha_colors (player_id, mecha_color_id, status) " +
                        "VALUES ($1, $2, $3) " +
                        "ON CONFLICT (player_id, mecha_color_id) DO UPDATE " +
                        "  SET status = excluded.status";
                    let qvars = [this.Player.player_id,save_data[k].mecha_color_id,save_data[k].status];
                    let res = await this.db.query(qtext, qvars);
                }
            } else if (j == "weapon_set") {
                let save_data = JSON.parse(req_body[j]);
                for(let k in save_data) {
                    let qtext = "INSERT INTO player_weapon_set (player_id, weapon_set_id, use_count, use_time, status) " +
                        "VALUES ($1, $2, $3, $4, $5) " +
                        "ON CONFLICT (player_id, weapon_set_id) DO UPDATE " +
                        "  SET use_count = excluded.use_count, use_time = excluded.use_time,status = excluded.status";
                    let qvars = [this.Player.player_id,save_data[k].weapon_set_id, save_data[k].use_count, save_data[k].use_time, save_data[k].status];
                    let res = await this.db.query(qtext, qvars);
                }
            } else if (j == "weapon_set_slots") {
                let save_data = JSON.parse(req_body[j]);
                for(let k in save_data) {
                    let qtext = "INSERT INTO player_weapon_set_slots (player_id, weapon_set_id, slot_id, weapon_id, use_count, use_time) " +
                        "VALUES ($1, $2, $3, $4, $5, $6) " +
                        "ON CONFLICT (player_id, weapon_set_id, slot_id) DO UPDATE " +
                        " SET weapon_id=excluded.weapon_id," +
                        " use_count = excluded.use_count, use_time = excluded.use_time";
                    let qvars = [this.Player.player_id,save_data[k].weapon_set_id, save_data[k].slot_id,save_data[k].weapon_id,save_data[k].use_count,save_data[k].use_time];
                    let res = await this.db.query(qtext, qvars);
                }
            } else if (j == "side_weapons") {
                let save_data = JSON.parse(req_body[j]);
                for(let k in save_data) {
                    let qtext = "INSERT INTO player_side_weapons (player_id, side_weapon_id, use_count, use_time, status) " +
                        "VALUES ($1, $2, $3, $4, $5) " +
                        "ON CONFLICT (player_id, side_weapon_id) DO UPDATE " +
                        "  SET use_count = excluded.use_count, use_time = excluded.use_time,status = excluded.status";
                    let qvars = [this.Player.player_id,save_data[k].side_weapon_id, save_data[k].use_count,save_data[k].use_time,save_data[k].status];
                    let res = await this.db.query(qtext, qvars);
                }
            } else if (j == "title_id_2on2") {
                    let qtext = "UPDATE player SET title_id_2on2=$2 WHERE player_id=$1";
                    let qvars = [this.Player.player_id,req_body[j]];
                    let res = await this.db.query(qtext, qvars);
            } else if (j == "mecha_set_id") {
                let qtext = "UPDATE player SET mecha_set_id=$2 WHERE player_id=$1";
                let qvars = [this.Player.player_id,req_body[j]];
                let res = await this.db.query(qtext, qvars);
            } else if (j == "emblem_id_2on2") {
                let qtext = "UPDATE player SET emblem_id_2on2=$2 WHERE player_id=$1";
                let qvars = [this.Player.player_id,req_body[j]];
                let res = await this.db.query(qtext, qvars);
            } else if (j == "line_color_id_2on2") {
                let qtext = "UPDATE player SET line_color_id_2on2=$2 WHERE player_id=$1";
                let qvars = [this.Player.player_id,req_body[j]];
                let res = await this.db.query(qtext, qvars);
            } else if (j == "side_weapon_id") {
                let qtext = "UPDATE player SET side_weapon_id=$2 WHERE player_id=$1";
                let qvars = [this.Player.player_id, req_body[j]];
                let res = await this.db.query(qtext, qvars);
            } else if (j == "mecha_preset_id") {
                let qtext = "UPDATE player SET mecha_preset_id=$2 WHERE player_id=$1";
                let qvars = [this.Player.player_id, req_body[j]];
                let res = await this.db.query(qtext, qvars);
            } else if (j == "rank_point") {
                let qtext = "UPDATE player SET rank_point=$2 WHERE player_id=$1";
                let qvars = [this.Player.player_id, req_body[j]];
                let res = await this.db.query(qtext, qvars);
            } else if (j == "max_rank_id") {
                let qtext = "UPDATE player SET max_rank_id=$2 WHERE player_id=$1";
                let qvars = [this.Player.player_id, req_body[j]];
                let res = await this.db.query(qtext, qvars);
            } else if (j == "rank_point_2on2") {
                let qtext = "UPDATE player SET rank_point_2on2=$2 WHERE player_id=$1";
                let qvars = [this.Player.player_id, req_body[j]];
                let res = await this.db.query(qtext, qvars);
            } else if (j == "max_rank_id_2on2") {
                let qtext = "UPDATE player SET max_rank_id_2on2=$2 WHERE player_id=$1";
                let qvars = [this.Player.player_id, req_body[j]];
                let res = await this.db.query(qtext, qvars);
            } else if (j == "buddy_id") {
                let qtext = "UPDATE player SET buddy_id=$2 WHERE player_id=$1";
                let qvars = [this.Player.player_id, req_body[j]];
                let res = await this.db.query(qtext, qvars);
            } else if (j == "player_id") {
                // Supress unknown data warning
            } else {
                console.log("##############################");
                console.log("## UNHANDLED DATA SAVE TYPE ##");
                console.log("##############################");
            }
            // WTF, missions should be spammed on each save?
            let qtext = "SELECT mission_id,clear_count,clear_num,status,mission_status FROM player_missions WHERE player_id=$1";
            let res = await this.db.query(qtext, [this.Player.player_id]);
            gameData.missions = [];
            for(let k in res.rows) {
                gameData.missions.push(res.rows[k]);
            }
        }
        gameData.result=1;
        return gameData;
    }
    getPlayerID() { return this.Player.player_id }
}

exports.PlayerProfile = PlayerProfile;