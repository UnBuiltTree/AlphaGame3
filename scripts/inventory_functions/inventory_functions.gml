function inventory_search(_root_object, _item_type){
	for (var i = 0; i < INVENTORY_SLOTS; i+=1) {
	    if (_root_object.inventory[i] == _item_type)
		{
			return(i);
		}
	}
	return(-1);
}

function inventory_remove(_root_object, _item_type){
	var _slot = inventory_search(_root_object, _item_type);
	if (_slot != -1){
		with (_root_object){inventory[_slot] = -1;}
		return(true);
	} else {
		return(false);
	}
}

function inventory_remove_slot(_root_object, _slot) {
    if (_slot >= 0 && _slot < INVENTORY_SLOTS) {
        var _item = _root_object.inventory[_slot];
		//show_debug_message("Slot: "+string(_slot)+" , Item: "+string(_item))
        _root_object.inventory[_slot] = -1;
        return _item;
    }
    return -1;
}

function find_first_empty_slot(_root_object) {
    for (var i = 0; i < INVENTORY_SLOTS; i++) {
        if (_root_object.inventory[i] == -1) {
            return i;
        }
    }
    return -1;
}

function find_last_occupied_slot(_root_object) {
    for (var i = INVENTORY_SLOTS - 1; i >= 0; i--) {
        if (_root_object.inventory[i] != -1) {  
            return i;
        }
    }
    return -1; //return 0 if all slots are empty
}

function inventory_add(_root_object, _item_type){
	var _slot = inventory_search(_root_object, -1);
	if (_slot != -1){
		with (_root_object){inventory[_slot] = _item_type;}
		return(true);
	} else {
		return(false);
	}
}

function create_item(_item_id, _x, _y){
	var _item = instance_create_layer(_x, _y,"Instances", obj_item);
		_item.item_initialize(_item_id)
}