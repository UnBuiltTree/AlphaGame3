
current_x = x;
current_y = y;

aim_direction = point_direction(x, y+ycenter_offset, mouse_x, mouse_y)

// Checks if the game isnt paused
if (obj_game_mgr.curr_game_state != GAME_STATE.PAUSED){
	if (obj_game_mgr.curr_game_state == GAME_STATE.PLAYING){
		if (mecha_local_id == 0){
			
			// Check for collision at the new position
			particle_manager();
			collision_manager(true, false);
			
			if (mecha_curr_health > mecha_max_health){
				mecha_curr_health -= 0.6;
			}
			
			_button_cooldown--;
			if (_boost_cooldown >= 0){
				_boost_cooldown--;
			}
			/*
			_damage_cooldown--;
			
			if (mecha_health <= 0){
				explode(death_explosion)
			}
			*/
			if (_speed > move_speed_max){
				_speed -= 4;
				speed = _speed/10;
			} else if (_speed > 0) {
				_speed -= 0.5;
				speed = _speed/10;
			}
			
			// Keyboard movement controls
			// Initial checks for each direction
			if (!collision){
				var up = keyboard_check(ord("W")) || keyboard_check(vk_up);
				var down = keyboard_check(ord("S")) || keyboard_check(vk_down);
				var left = keyboard_check(ord("A")) || keyboard_check(vk_left);
				var right = keyboard_check(ord("D")) || keyboard_check(vk_right);
			
				var boost =keyboard_check(vk_space);

			// horizontal and vertical movement
			var move_horizontally = left != right; // true if either left or right is pressed, but not both
			var move_vertically = up != down; // true if either up or down is pressed, but not both
			walking = false;
			
			// finds direction based on key presses
			if (move_vertically || move_horizontally) {
			    if (move_vertically) {
			        if (up) {direction = 90; walk_spr = spr_mecha_leg_up_walk}
			        if (down) {direction = 270; walk_spr = spr_mecha_leg_dn_walk}
					walking = true;
			    }
    
			    if (move_horizontally) {
			        if (left) {direction = 180; walk_spr = spr_mecha_leg_lf_walk}
			        if (right) {direction = 0; walk_spr = spr_mecha_leg_rt_walk}
					walking = true;
			    }
    
			    //adjust for diagonal movement
			    if (move_vertically && move_horizontally) {
			        if (up && right) {direction = 45; walk_spr = spr_mecha_leg_up_walk}
			        if (up && left) {direction = 135; walk_spr = spr_mecha_leg_lf_walk}
			        if (down && left) {direction = 225; walk_spr = spr_mecha_leg_dn_walk}
			        if (down && right) {direction = 315; walk_spr = spr_mecha_leg_rt_walk}
					walking = true;
			    }

				
					last_direction = direction;
				    if (_speed < move_speed_max) _speed += move_acceleration;

				    // adjust speed for diagonal movement
				    if (move_vertically && move_horizontally) {
				        //speed = sqrt(_speed);
				    }
				}
				if (boost && (_boost_cooldown <= 0)) { 
					_speed = boost_speed;
					boost_available = false;
					_boost_cooldown = boost_cooldown;
				}
			}
			collision = false;
			
			// end keybaord movement control
			
			if (mouse_check_button(mb_left))
				{
					var _trigger_type = "gun_left";
					trigger_pressed(_trigger_type, _mecha_guns);
				}
				
			if (global.gun_one_cooldown >= 0){
				global.gun_one_cooldown--
			}
			
			if (keyboard_check(ord("M")))
				{
					if (_button_cooldown <= 0){
						destroy_fuction(last_direction, eject_speed);
						}
					_button_cooldown = button_cooldown;
					}
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
						mecha_curr_health -= 20;
						}
					_button_cooldown = button_cooldown;
					}
				if (keyboard_check(ord("H")))
				{
					if (_button_cooldown <= 0){
						mecha_curr_health += 20;
						}
					_button_cooldown = button_cooldown;
					}
				if (keyboard_check(ord("V")))
				{
					if (_button_cooldown <= 0){
						if (!global.show_walls){
							global.show_walls = true
						} else {
							global.show_walls = false
						}
					_button_cooldown = button_cooldown;
					}
				}
				if (keyboard_check(ord("G")))
				{
					if (_button_cooldown <= 0){
						room_restart()
					_button_cooldown = button_cooldown;
					}
				}
			
				
			if (mecha_curr_health <= 0){
				destroy_fuction(direction, eject_speed);
			}
		}
	}
}


