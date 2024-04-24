if (global.picking_up){
	if (find_first_empty_slot(obj_inventory) != -1){
		inventory_add(obj_inventory, item_id);
		instance_destroy(self)
	}
}