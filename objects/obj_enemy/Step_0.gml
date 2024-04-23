collision_manager(1, false);

if (enemy_curr_health <= 0){
	if (drop_){
		var _item = instance_create_layer(x, y,"Instances", obj_item);
		_item.item_initialize(irandom_range(1,4))
	}
	instance_destroy(self);
}