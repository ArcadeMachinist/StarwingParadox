const fs = require('fs');

let fileToProcess = process.argv[2];// "rankingNational.json";

let r_national = JSON.parse(fs.readFileSync(fileToProcess,'utf8'));

Object.prototype.getByIndex = function(index) {
    return this[Object.keys(this)[index]];
};

console.log(Object.keys(r_national)[3]);
//console.log(r_national.getByIndex(3));

let thisFileRecordsHolder = Object.keys(r_national)[3];

if (thisFileRecordsHolder == "LocationName") {
    thisFileRecordsHolder = Object.keys(r_national)[4];
    r_national.location_name = r_national.LocationName;
    delete r_national.LocationName;
}
if (thisFileRecordsHolder == "PrefName") {
    thisFileRecordsHolder = Object.keys(r_national)[4];
    r_national.pref_name = r_national.PrefName;
    delete r_national.PrefName;
}
//console.log(r_national[thisFileRecorsHolder]);

r_national.updated_at = r_national.UpdatedAt;
delete r_national.UpdatedAt;

r_national.fixed_term = new Object();
r_national.fixed_term.from_at = r_national.FixedTermFromAt;
r_national.fixed_term.to_at = r_national.FixedTermToAt;
delete r_national.FixedTermFromAt;
delete r_national.FixedTermToAt;

r_national.records = r_national[thisFileRecordsHolder];
delete r_national[thisFileRecordsHolder];




r_national.records.forEach(element => {
//    console.log(element);

    element.order = element.Order;
    delete element.Order;

    element.change = element.ChangeID;
    delete element.ChangeID;

    element.emblem = new Object();
    element.emblem.outline = new Object();
    element.emblem.main_design= new Object();
    element.emblem.sub_design= new Object();

    element.emblem.outline.part_id = element.EmblemData[0].EmblemPartsID;
    element.emblem.outline.offset = element.EmblemData[0].Offset;
    element.emblem.outline.scale = element.EmblemData[0].Scale;
    element.emblem.outline.angle = element.EmblemData[0].Angle;

    element.emblem.main_design.part_id = element.EmblemData[1].EmblemPartsID;
    element.emblem.main_design.offset = element.EmblemData[1].Offset;
    element.emblem.main_design.scale = element.EmblemData[1].Scale;
    element.emblem.main_design.angle = element.EmblemData[1].Angle;

    element.emblem.sub_design.part_id = element.EmblemData[2].EmblemPartsID;
    element.emblem.sub_design.offset = element.EmblemData[2].Offset;
    element.emblem.sub_design.scale = element.EmblemData[2].Scale;
    element.emblem.sub_design.angle = element.EmblemData[2].Angle;

    delete element.EmblemData;

    element.mecha = element.Mecha;
    delete element.Mecha;

    element.mecha.head = new Object();
    element.mecha.head.part_id = element.mecha.Head[0];
    element.mecha.head.mecha_id = element.mecha.Head[1];
    element.mecha.head.design_id = element.mecha.Head[2];
    element.mecha.head.color_id = element.mecha.Head[3];

    element.mecha.body = new Object();
    element.mecha.body.part_id = element.mecha.Body[0];
    element.mecha.body.mecha_id = element.mecha.Body[1];
    element.mecha.body.design_id = element.mecha.Body[2];
    element.mecha.body.color_id = element.mecha.Body[3];

    element.mecha.arm = new Object();
    element.mecha.arm.part_id = element.mecha.Arm[0];
    element.mecha.arm.mecha_id = element.mecha.Arm[0];
    element.mecha.arm.design_id = element.mecha.Arm[0];
    element.mecha.arm.color_id = element.mecha.Arm[0];

    element.mecha.foot = new Object();
    element.mecha.foot.part_id = element.mecha.Foot[0];
    element.mecha.foot.mecha_id = element.mecha.Foot[0];
    element.mecha.foot.design_id = element.mecha.Foot[0];
    element.mecha.foot.color_id = element.mecha.Foot[0];

    element.mecha.back_pack = new Object();
    element.mecha.back_pack.part_id = element.mecha.Backpack[0];
    element.mecha.back_pack.mecha_id = element.mecha.Backpack[0];
    element.mecha.back_pack.design_id = element.mecha.Backpack[0];
    element.mecha.back_pack.color_id = element.mecha.Backpack[0];

    element.mecha.is_decal = element.mecha.Decal;
    element.mecha.line_color_id = element.mecha.LineColor;

    delete element.mecha.Head;
    delete element.mecha.Body;
    delete element.mecha.Arm;
    delete element.mecha.Foot;
    delete element.mecha.Backpack;
    delete element.mecha.Decal;
    delete element.mecha.LineColor;

    element.player_name = element.PlayerName;
    element.buddy_id = element.BuddyID;
    element.title_id = element.TitleID;
    element.rank_id = element.RankID;
    element.score =  element.Score;
    element.pref_name = element.PrefName;
    element.group_name = element.GroupName;
    element.weapon_set_id_list = element.WeaponSetId_List;
    element.side_weapon_id_list = element.SideWeaponId_List;

    delete element.PlayerName;
    delete element.BuddyID;
    delete element.TitleID;
    delete element.RankID;
    delete element.Score;
    delete element.PrefName;
    delete element.GroupName;
    delete element.WeaponSetId_List;
    delete element.SideWeaponId_List



});
fs.writeFile("c_"+fileToProcess, JSON.stringify(r_national, null, 4), function(err) {
    if(err) {
        console.log(err);
    } else {
        console.log("JSON saved ");
    }
});
//console.log(JSON.stringify(r_national,null,4));
