var addOptionTextCount = 0;
var select_users
var subordinates
var leader_id
var child_param_name = "leader_leader_user_links"

/* global $*/
$(function() {
    select_users = JSON.parse(document.getElementById('select_users').dataset.json);
    subordinates = JSON.parse(document.getElementById('subordinates').dataset.json);
    // 種別ループ
    // for (let subordinate in subordinates) {
    Object.keys(subordinates).forEach(function (key) {
        var subordinate = subordinates[key]
        leader_id = subordinate.leader_id
        addSubordinatesArea(subordinate.id);
        initSubordinatesSelct(subordinate.id);
    });
});

function initSubordinatesSelct(subordinate_subordinat_id){
    var tmp = (addOptionTextCount - 1)
    var id ="form_user_" + child_param_name + "_attributes_"+ tmp +"_subordinate_id"
    $("#" + id).val(subordinate_subordinat_id);
}

function addSubordinatesArea(subordinate_id) {
	var addArea = document.getElementById("subordinates-tbody");
// 	var id = "subordinates-selct-" + addOptionTextCount;
    var id_id = "form_user_" + child_param_name + "attributes_"+ addOptionTextCount  +"_id"
    var id_name = "form_user[" + child_param_name + "]["+ addOptionTextCount  +"][id]"
    
    var leader_id_name = "form_user[" + child_param_name + "]["+ addOptionTextCount + "][leader_id]"
    var leader_id_id = "form_user_" + child_param_name + "_attributes_"+ addOptionTextCount  + "_leader_id"
	
	var subordinate_id_name = "form_user[" + child_param_name + "]["+ addOptionTextCount  +"][subordinate_id]"
    var subordinate_id_id = "form_user_" + child_param_name + "_attributes_"+ addOptionTextCount  +"_subordinate_id"
    
    
    var destroy_name = "form_user[" + child_param_name + "]["+ addOptionTextCount  +"][_destroy]"
    var destroy_id = "form_user_" + child_param_name + "_attributes_"+ addOptionTextCount  +"__destroy"

    var insertHTML = '<tr class="nested-fields"><tr class="nested-fields"><input type="hidden" name="'
	                + id_name
	                + '" id="'
	                + id_id
	                + '"><input type="hidden" value="'
	                + leader_id
	                + '"name="'
	                + leader_id_name
	                + '" id="'
	                + leader_id_id
	                + '"><td><select class="form-control" id="' 
	                + subordinate_id_id 
	                +'" name="' 
	                + subordinate_id_name
	                +'"><option value=""></option></select></td><td><input value="false" type="hidden" name="'
                    + destroy_name
                    + '" id="'
                    + destroy_id
                    + '"><a class="btn btn-default remove_fields existing" onclick="deleteTableRow(this)">削除</a></td></tr>';
	if(subordinate_id){
	    insertHTML = '<tr class="nested-fields"><tr class="nested-fields"><input type="hidden" value="'
	                + subordinate_id
	                + '" name="'
	                + id_name
	                + '" id="'
	                + id_id
	                + '"><input type="hidden" value="'
	                + leader_id
	                + '"name="'
	                + leader_id_name
	                + '" id="'
	                + leader_id_id
	                + '"><td><select class="form-control" id="' 
	                + subordinate_id_id 
	                +'" name="' 
	                + subordinate_id_name 
	                +'"><option value=""></option></select></td><td><input value="false" type="hidden" name="'
                    + destroy_name
                    + '" id="'
                    + destroy_id
                    + '"><a class="btn btn-default remove_fields existing" onclick="deleteTableRow(this)">削除</a></td></tr>';
	}
    addArea.insertAdjacentHTML("beforeend", insertHTML);
    
    // for (let select_user in select_users) {
    Object.keys(select_users).forEach(function (key) {
        var select_user = select_users[key]
        $('#'+ subordinate_id_id).append($('<option>').html(select_user.name).val(select_user.id));
    });
    
	addOptionTextCount = addOptionTextCount + 1;
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