var _slot = find_last_occupied_slot(id);

if (_slot != -1){
	var _x = obj_mecha.x - 8
	var _y = obj_mecha.y - 16
	var _item = inventory_remove_slot(id, _slot);
	create_item(_item, _x, _y + 6);
}