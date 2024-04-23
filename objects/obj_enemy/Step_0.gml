collision_manager(1, false);

if (enemy_curr_health <= 0){
	if (drop_){
		create_item(random_item(), x - 8, y - 16);
	}
	instance_destroy(self);
}