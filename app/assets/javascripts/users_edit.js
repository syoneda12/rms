var addOptionTextCount = 0;
var skill_kind_hash
var skill_all
var skill_kind_all
var skill_level_all

/* global $*/
$(function() {
    skill_kind_hash = JSON.parse(document.getElementById('skill_kind_hash').dataset.json);
    skill_all = JSON.parse(document.getElementById('skill_all').dataset.json);
    skill_kind_all = JSON.parse(document.getElementById('skill_kind_all').dataset.json);
    skill_level_all = JSON.parse(document.getElementById('skill_level_all').dataset.json);
    // 種別ループ
    Object.keys(skill_kind_hash).forEach(function (key) {
        var skill_kind_name = key;
        var kindId = getKeyByValue(skill_kind_all,skill_kind_name);
        // 保有スキルループ
        Object.keys(skill_kind_hash[key]).forEach(function (skillKey) {
            initAddSkillArea(kindId,skill_kind_hash[key][skillKey]);
        });
    });
});

function getKeyByValue(hash, val){
    var ret
    Object.keys(hash).filter( (key) => { 
        if(hash[key].name === val){
            ret = hash[key].id
        }
    });
    return ret;
}

function initAddSkillArea(skillkindId,user_skills) {
	var addArea = document.getElementById("detail-association-insertion-point" + skillkindId);
	var key = "skill" + addOptionTextCount;
	var val = "level" + addOptionTextCount;
	
    var tr = "tr_"+ addOptionTextCount
	var idName = "form_user[user_skill_links_attributes]["+ addOptionTextCount  +"][id]"
	var skillIdName = "form_user[user_skill_links_attributes]["+ addOptionTextCount +"][skill_id]"
	var skillLevelIdName = "form_user[user_skill_links_attributes]["+ addOptionTextCount  +"][skill_level_id]"
	var hideName = "form_user[user_skill_links_attributes]["+ addOptionTextCount  +"][hide]"
	var destroyName = "form_user[user_skill_links_attributes][" + addOptionTextCount + "][_destroy]"
	
	var idId = "form_user_user_skill_links_attributes_"+ addOptionTextCount  +"_id"
	var skillIdId = "form_user_user_skill_links_attributes_"+ addOptionTextCount  +"_skill_id"
	var skillLevelIdId = "form_user_user_skill_links_attributes_"+ addOptionTextCount +"_skill_level_id"
	var hideId = "form_user_user_skill_links_attributes_"+ addOptionTextCount +"_hide"
	var destroyId = "form_user_user_skill_links_attributes_"+ addOptionTextCount + "__destroy"
	
	var input_hide_on = '<input type="checkbox" name="'
                    + hideName
                    + '" id="'
                    + hideId
                    + '" value="1">'
	var input_hide_off = '<input type="hidden" name="'
                    + hideName
                    + '" value="0">'
    var td_hide = '<td>'  + input_hide_off + input_hide_on + '</td>'
	
	var insertHTML = '<tr id="'
	                + tr
	                + '" class="nested-fields"><input type="hidden" value="'
	                + user_skills["user_skill_link_id"]
	                + '" name="'
	                + idName
	                + '" id="'
	                + idId
	                + '"><td><select class="form-control" name="'
                    + skillIdName
                    + '" id="'
                    + skillIdId
                    + '"><option value=""></option></select></td><td><select class="form-control" name="'
                    + skillLevelIdName
                    + '" id="'
                    + skillLevelIdId
                    + '"><option value=""></option></select></td>'
                    + td_hide
                    + '<td><input value="false" type="hidden" name="'
                    + destroyName
                    + '" id="'
                    + destroyId
                    + '"><a class="btn btn-default remove_fields existing" onclick="deleteTableRow(this,' + addOptionTextCount + ')">削除</a></td></tr>';
    addArea.insertAdjacentHTML("beforeend", insertHTML);
    
    Object.keys(skill_all).forEach(function (key) {
        if(skillkindId == skill_all[key].skill_kind_id){
            $('#'+skillIdId).append($('<option>').html(skill_all[key].name).val(skill_all[key].id));
        }
    });
    Object.keys(skill_level_all).forEach(function (key) {
       $('#'+ skillLevelIdId).append($('<option>').html(skill_level_all[key].name).val(skill_level_all[key].id));
    });
    $("#"+skillIdId).val(user_skills["skill_id"]);
    $("#"+skillLevelIdId).val(user_skills["skill_level_id"]);
    if (user_skills["hide"] == 1){
        $("#"+hideId).prop('checked', true);
    }
	addOptionTextCount = addOptionTextCount + 1;
}

function addSkillArea(skillkindId){
	var addArea = document.getElementById("detail-association-insertion-point" + skillkindId);
	var key = "skill" + addOptionTextCount;
	var val = "level" + addOptionTextCount;
	var tr = "tr_"+ addOptionTextCount
	var idName = "form_user[user_skill_links_attributes]["+ addOptionTextCount  +"][id]"
	var skillIdName = "form_user[user_skill_links_attributes]["+ addOptionTextCount  +"][skill_id]"
	var skillLevelIdName = "form_user[user_skill_links_attributes]["+ addOptionTextCount +"][skill_level_id]"
	var hideName = "form_user[user_skill_links_attributes]["+ addOptionTextCount  +"][hide]"
	var destroyName = "form_user[user_skill_links_attributes][" + addOptionTextCount + "][_destroy]"
	
	var idId = "form_user_user_skill_links_attributes_"+ addOptionTextCount  +"_id"
	var skillIdId = "form_user_user_skill_links_attributes_"+ addOptionTextCount  +"_skill_id"
	var skillLevelIdId = "form_user_user_skill_links_attributes_"+ addOptionTextCount  +"_skill_level_id"
	var hideId = "form_user_user_skill_links_attributes_"+ addOptionTextCount +"_hide"
	var destroyId = "form_user_user_skill_links_attributes_"+ addOptionTextCount + "__destroy"
	
	var input_hide_on = '<input type="checkbox" name="'
                    + hideName
                    + '" id="'
                    + hideId
                    + '" value="1">'
	var input_hide_off = '<input type="hidden" name="'
                    + hideName
                    + '" value="0">'
    var td_hide = '<td>'  + input_hide_off + input_hide_on + '</td>'
	
	var insertHTML = '<tr id="'
	                + tr
	                + '"class="nested-fields"><input type="hidden" name="'
	                + idName
	                + '" id="'
	                + idId
	                + '"><td><select class="form-control" name="'
                    + skillIdName
                    + '" id="'
                    + skillIdId
                    + '"><option value=""></option></select></td><td><select class="form-control" name="'
                    + skillLevelIdName
                    + '" id="'
                    + skillLevelIdId
                    + '"><option value=""></option></select></td>'
                    + td_hide
                    +'<td><input value="false" type="hidden" name="'
                    + destroyName
                    + '" id="'
                    + destroyId
                    + '"><a class="btn btn-default remove_fields existing" onclick="deleteTableRow(this,' + addOptionTextCount + ')">削除</a></td></tr>';
    addArea.insertAdjacentHTML("beforeend", insertHTML);
    
    Object.keys(skill_all).forEach(function (key) {
        if(skillkindId == skill_all[key].skill_kind_id){
            $('#'+skillIdId).append($('<option>').html(skill_all[key].name).val(skill_all[key].id));
        }
    });
    Object.keys(skill_level_all).forEach(function (key) {
       $('#'+ skillLevelIdId).append($('<option>').html(skill_level_all[key].name).val(skill_level_all[key].id));
    });
    addOptionTextCount = addOptionTextCount + 1;
}

/**
 * 行削除
 */
function deleteTableRow(obj,addOptionTextCount) {
    $('#'+"form_user_user_skill_links_attributes_" + addOptionTextCount + "__destroy").val(true);
    $('#tr_' + addOptionTextCount).hide();
}