
player_initialize = function(){
	
	player_local_id = 1;
	
	player_ysize = sprite_get_height(sprite_index);
	player_xsize = sprite_get_width(sprite_index);
	ycenter_offset = -player_ysize/2;
	
	//variables for player speeds
	speed = 0;
	_speed = 0;
	move_acceleration = 3;
	move_speed_max = 15;
	
	boost_speed = 40;
	_boost_cooldown = 0;
	boost_cooldown = 40;
	
	player_curr_health = 20;
	player_max_health = 40;
	
	last_direction = 0;
	
	aim_direction = 0;
	
	_button_cooldown = 0;
	button_cooldown = 8;
	_particle_cooldown = 0;
	particle_cooldown = 50;
	
	_frame_rate = 4;
	_frame = 0;
	walk_spr = spr_player_up_walk;
	walking = false;
	show_debug_message("Player Created")
}
	
drive_mecha = function(_x, _y){
	_direction = round(last_direction/45)*45
	var _mecha = instance_create_layer(_x, _y,"Instances", obj_mecha);
	_mecha.mecha_initialize();
	_mecha.direction = _direction;
	_mecha.mecha_local_id = 0;
	show_debug_message("Mecha Player Spawned: " + string(_mecha.mecha_local_id));
	global.player_alive = true;
	instance_destroy(self)
}
	
	
particle_manager = function(){
	if (_particle_cooldown > 0){
		_particle_cooldown--;
	}
	if (player_curr_health > player_max_health){
		if (_particle_cooldown <= 0) {
			var _health_particle instance_create_layer(x+random_range(-player_xsize/2, player_xsize/2), y-random_range(player_ysize/4, player_ysize),"hud", obj_health_particle)
			_particle_cooldown = random_range(particle_cooldown/4, particle_cooldown)
		}
	}
}

alarm[1] = 5;