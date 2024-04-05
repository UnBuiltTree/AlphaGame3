
player_initialize = function(){
	
	player_local_id = 0;
	
	player_ysize = sprite_get_height(sprite_index);
	player_xsize = sprite_get_width(sprite_index);
	ycenter_offset = -player_ysize/2;
	
	//variables for player speeds
	speed = 0;
	_speed = 0;
	move_speed = 20;
	
	last_direction = 0;
	
	aim_direction = 0;
	
	_button_cooldown = 0;
	button_cooldown = 8;
	
	show_debug_message("Player Created")
}