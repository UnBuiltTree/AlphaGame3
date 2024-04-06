
current_x = x;
current_y = y;

aim_direction = point_direction(x, y+ycenter_offset, mouse_x, mouse_y)

// Checks if the game isnt paused
if (obj_game_mgr.curr_game_state != GAME_STATE.PAUSED){
	if (obj_game_mgr.curr_game_state == GAME_STATE.PLAYING){
		if (player_local_id == 0){
			
			if (player_curr_health <= 0){
				instance_destroy(self)
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
				_speed -= 4;
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

			// finds direction based on key presses
			if (move_vertically || move_horizontally) {
			    if (move_vertically) {
			        if (up) direction = 90;
			        if (down) direction = 270;
			    }
    
			    if (move_horizontally) {
			        if (left) direction = 180;
			        if (right) direction = 0;
			    }
    
			    //adjust for diagonal movement
			    if (move_vertically && move_horizontally) {
			        if (up && right) direction = 45;
			        if (up && left) direction = 135;
			        if (down && left) direction = 225;
			        if (down && right) direction = 315;
			    }
				
				last_direction = direction;
			    if (_speed < move_speed_max) _speed += move_acceleration;

			    // adjust speed for diagonal movement
			    if (move_vertically && move_horizontally) {
			        //speed = sqrt(_speed);
			    }
			}
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
				}
				
				if (keyboard_check(ord("H")))
				{
					if (_button_cooldown <= 0){
						player_curr_health += 5;
						}
					_button_cooldown = button_cooldown;
					}
				

		}
	}
}


