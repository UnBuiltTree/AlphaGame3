
current_x = x;
current_y = y;

aim_direction = point_direction(x, y+ycenter_offset, mouse_x, mouse_y)

// Checks if the game isnt paused
if (obj_game_mgr.curr_game_state != GAME_STATE.PAUSED){
	if (obj_game_mgr.curr_game_state == GAME_STATE.PLAYING){
		if (player_local_id == 0){
			
			particle_manager();
			
			if (player_curr_health < 0){
				instance_destroy(self)
			}
			
			if (player_curr_health > player_max_health){
				player_curr_health -= 0.2;
			}
			
			_button_cooldown--;
			if (_boost_cooldown >= 0){
				_boost_cooldown--;
			}
			/*
			_damage_cooldown--;
			
			if (player_health <= 0){
				explode(death_explosion)
			}
			*/
			if (_speed > move_speed_max){
				_speed -= 2;
				speed = _speed/10;
			} else if (_speed > 0) {
				_speed -= 0.5;
				speed = _speed/10;
			}
			
			// Keyboard movement controls
			// Initial checks for each direction
			var up = keyboard_check(ord("W")) || keyboard_check(vk_up);
			var down = keyboard_check(ord("S")) || keyboard_check(vk_down);
			var left = keyboard_check(ord("A")) || keyboard_check(vk_left);
			var right = keyboard_check(ord("D")) || keyboard_check(vk_right);
			
			var boost =keyboard_check(vk_space);

			// horizontal and vertical movement
			var move_horizontally = left != right; // true if either left or right is pressed, but not both
			var move_vertically = up != down; // true if either up or down is pressed, but not both
			var target_direction = direction;
			
			walking = false;
			
			// finds direction based on key presses
			if (move_vertically || move_horizontally) {
			    if (move_vertically) {
			        if (up) { target_direction = 90; walk_spr = spr_player_up_walk}
			        if (down) { target_direction = 270; walk_spr = spr_player_dn_walk}
					walking = true;
			    }

			    if (move_horizontally) {
			        if (left) {target_direction = 180; walk_spr = spr_player_lf_walk}
			        if (right) {target_direction = 0; walk_spr = spr_player_rt_walk}
					walking = true;
			    }

			    if (move_vertically && move_horizontally) {
			        if (up && right) {target_direction = 45; walk_spr = spr_player_up_walk}
			        if (up && left) {target_direction = 135; walk_spr = spr_player_lf_walk}
			        if (down && left) {target_direction = 225; walk_spr = spr_player_dn_walk}
			        if (down && right) {target_direction = 315; walk_spr = spr_player_rt_walk}
					walking = true;
			    }
				
				last_direction = direction;
			    if (_speed < move_speed_max) _speed += move_acceleration;
			}
			// Rotate towards target direction by 5 degrees, accounting for seam between 0 and 360 degrees
			if (_speed < 10) {
			    direction = target_direction;
			} else {
				var direction_difference = target_direction - direction;

				// Adjust for the shortest distance considering the 360 degrees wraparound
				if (direction_difference > 180) {
				    direction_difference -= 360;
				} else if (direction_difference < -180) {
				    direction_difference += 360;
				}

				if (direction_difference != 0) {
				    if (direction_difference > 0) {
				        direction += (abs(direction_difference) >= 5) ? 5 : abs(direction_difference);
				    } else {
				        direction -= (abs(direction_difference) >= 5) ? 5 : abs(direction_difference);
				    }
				}
			}

			// Normalize direction to the range [0, 360)
			direction = (direction + 360) % 360;

			// end keybaord movement control
			if (boost && (_boost_cooldown <= 0)) { 
					_speed = boost_speed;
					boost_available = false;
					_boost_cooldown = boost_cooldown;
				}
			// --- debuging tools
			if (keyboard_check(ord("B")))
				{
					if (_button_cooldown <= 0){
						if (!global.debug_mode){
							global.debug_mode = true
							global.cheat_mode = true
						} else {
							global.debug_mode = false
							global.cheat_mode = false
						}
					_button_cooldown = button_cooldown;
					}
				}
			if (global.debug_mode)
				{
				if (keyboard_check(ord("J")))
				{
					if (_button_cooldown <= 0){
						player_curr_health -= 5;
						}
					_button_cooldown = button_cooldown;
					}
				if (keyboard_check(ord("H")))
				{
					if (_button_cooldown <= 0){
						player_curr_health += 5;
						}
					_button_cooldown = button_cooldown;
					}
				}
				if (keyboard_check(ord("N")))
				{
					if (_button_cooldown <= 0){
						var _mecha = instance_create_layer(mouse_x, mouse_y,"Instances", obj_mecha_mount);
					}
					_button_cooldown = button_cooldown;
				}
				
		}
	}
}


