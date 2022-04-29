class BattleRecorder {
    constructor(db) {
        this.db = db;
    }
    async battleRecord2on2(req_body){
        let response = new Object();

        response.winning_streaks_2on2 = 1;
        response.rank_point_2on2 = 10000;
        response.ranking_score_2on2 = 500;
        response.ranking_high_score_2on2 = 1000;
        response.gained_ranking_score_2on2 = 200;
        response.is_update_rank_point_2on2 = true;
        response.is_update_ranking_score_2on2 = true;
        response.is_up_ranking_score_2on2 = true;
        response.is_new_record_ranking_score_2on2 = true;

        // Looks like here server pushes only what was updated in PlayerData - see FCPP_HttpJsonSerialize::UpdateItem
        response.update_items = new Object();
        response.update_items.game_moneys = [];
        let gamemoney = new Object;
        gamemoney.game_money_id=1;
        gamemoney.count = 50; // array of {"game_money_id": 0, "count": 0}
        response.update_items.game_moneys.push(gamemoney);


        response.battle_reward_ids = [1];  // Array of plain ints
        response.rank_up_reward_ids = [2]; // same as above, rewards are the same
        response.rank_point_reward_ids = [3];
        response.intimacy_up_reward_ids = [4];
        response.avg_minute_score = new Object();
        response.avg_minute_score.stage_id = req_body.stage_id;
        response.avg_minute_score.rank_id = 1;
        response.avg_minute_score.avg_minute_score = 44;

        let qtext = "SELECT mission_id,clear_count,clear_num,status,mission_status FROM player_missions WHERE player_id=$1";
        let res = await this.db.query(qtext, [req_body.player_id]);
        response.missions = [];
        for(let k in res.rows) {
            response.missions.push(res.rows[k]);
        }

        return response;
    }
}

exports.BattleRecorder = BattleRecorder;