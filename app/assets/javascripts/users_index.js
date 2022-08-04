var addOptionTextCount = 0;
var skill_all
var search_param_skill

/* global $*/
$(function() {
    skill_all = JSON.parse(document.getElementById('skill_all').dataset.json);
    var search_param = JSON.parse(document.getElementById('search_param').dataset.json);
    if(search_param.skill){
        for (const elem of search_param.skill) {
            if(elem){
                addSkillArea();
                setSkillSelect(elem);
            }
        };
    }
    $('#search_subordinate').prop('checked', search_param.subordinate);
    $('#search_subordinate2').prop('checked', search_param.subordinate);
    
});

function addSkillArea() {
	var addArea = document.getElementById("skill_select_area");
	var id = "search_skill_" + addOptionTextCount;
	var insertHTML = '<tr><td><select name="search[skill][]" id="' + id +'"><option value=""></option></select></td><td><a class="btn btn-default remove_fields existing" onclick="deleteTableRow(this)">削除</a></td></tr>';
    addArea.insertAdjacentHTML("beforeend", insertHTML);
   
    var addArea2 = document.getElementById("skill_select_area2");
    var id2 = "search_skill2_" + addOptionTextCount;
    var insertHTML2 = '<tr><td><select name="search[skill][]" id="' + id2 +'"><option value=""></option></select></td><td><a class="btn btn-default remove_fields existing" onclick="deleteTableRow(this)">削除</a></td></tr>';
    addArea2.insertAdjacentHTML("beforeend", insertHTML2);
    Object.keys(skill_all).forEach(function (key) {
       $('#'+ id).append($('<option>').html(skill_all[key].name).val(skill_all[key].id));
       $('#'+ id2).append($('<option>').html(skill_all[key].name).val(skill_all[key].id));
    });
	addOptionTextCount = addOptionTextCount + 1;
}

function setSkillSelect(skillId){
    var id = "search_skill_" + (addOptionTextCount - 1);
    $("#" + id).val(skillId);
    
    var id2 = "search_skill2_" + (addOptionTextCount - 1);
    $("#" + id2).val(skillId);
}

/**
 * 行削除
 */
function deleteTableRow(obj) {
    // 削除ボタンを押下された行を取得
    var tr = obj.parentNode.parentNode;
    // trのインデックスを取得して行を削除する
    tr.parentNode.deleteRow(tr.sectionRowIndex);
}