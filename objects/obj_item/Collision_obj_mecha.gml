if (global.picking_up){
	inventory_add(obj_inventory, item_id);
	instance_destroy(self)
}