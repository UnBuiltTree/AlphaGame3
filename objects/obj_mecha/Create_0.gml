
mecha_initialize = function(){
	mecha_local_id = 0;
	
	mecha_ysize = sprite_get_height(sprite_index);
	mecha_xsize = sprite_get_width(sprite_index);
	ycenter_offset = -mecha_ysize/2;
	
	//variables for player speeds
	speed = 0;
	_speed = 0;
	move_acceleration = 5;
	move_speed_max = 20;
	
	boost_speed = 100;
	_boost_cooldown = 0;
	boost_cooldown = 80;
	
	mecha_curr_health = 100;
	mecha_max_health = 100;
	
	eject_speed = 60;
	collision = false;
	
	last_direction = 0;
	
	aim_direction = 0;
	
	_button_cooldown = 0;
	button_cooldown = 8;
	
	_particle_cooldown = 0;
	particle_cooldown = 50;
	
	walking = false;
	_frame_rate = 16;
	_frame = 0;
	if (direction < 90){
		walk_spr = spr_mecha_leg_rt_walk;
	} else if (direction < 180){
		walk_spr = spr_mecha_leg_up_walk;
	} else if (direction < 270){
		walk_spr = spr_mecha_leg_lf_walk;
	} else {
		walk_spr = spr_mecha_leg_dn_walk;
	}
	torso_spr = spr_torso
	alarm[1] = _frame_rate;
	
	create_inventory();
	show_debug_message("Mecha Created")
}

destroy_fuction = function(last_direction, eject_speed){
	_direction = last_direction - 180
	var _human = instance_create_layer(x, y,"Instances", obj_player_human);
	_human.player_initialize();
	_human.direction = _direction;
	_human._speed = eject_speed;
	_human.player_local_id = 0;
	_human.player_curr_health = mecha_curr_health + _human.player_curr_health
	show_debug_message("Human Player Spawned: " + string(_human.player_local_id));
	show_debug_message(string(eject_speed));
	global.player_alive = true;
	destory_inventory();
	instance_destroy(self)
}
	
particle_manager = function(){
	if (_particle_cooldown > 0){
		_particle_cooldown--;
	}
	if (mecha_curr_health > mecha_max_health){
		if (_particle_cooldown <= 0) {
			var _health_particle instance_create_layer(x+random_range(-mecha_xsize/2, mecha_xsize/2), y-random_range(mecha_ysize/4, mecha_ysize),"hud", obj_health_particle)
			_particle_cooldown = random_range(particle_cooldown/4, particle_cooldown)
		}
	}
}
	
collision_manager = function(){
	// detect collision with a wall object
if (place_meeting(x + hspeed, y, obj_wall)) {
	collision = true;
	hspeed = hspeed/2
    // resolve horizontal overlap
    while (!place_meeting(x + sign(hspeed), y, obj_wall)) {
        x += sign(hspeed);
    }
    hspeed = -hspeed; // Invert horizontal speed after resolving overlap
}

if (place_meeting(x, y + vspeed, obj_wall)) {
	collision = true;
	vspeed = vspeed/2
    // resolve vertical overlap
    while (!place_meeting(x, y + sign(vspeed), obj_wall)) {
        y += sign(vspeed);
    }
    vspeed = -vspeed; // Invert vertical speed after resolving overlap
}
}
	
create_inventory = function(){
	var _inv = instance_create_layer(x, y,"Hud", obj_inventory);
}

destory_inventory = function(){
	instance_destroy(obj_inventory)
}