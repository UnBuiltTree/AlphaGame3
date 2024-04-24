//different level every play
//random_set_seed(25878349);
//25878349
//98732401
randomize()

//get tile layer ID
var _wall_map_id = layer_tilemap_get_id("WallTiles");

//setup grid
width_ = room_width div CELL_WIDTH;
height_ = room_height div CELL_HEIGHT;
boundary_size_ = 6;
max_room_size = 16;
min_room_size = 6;
min_space_distance_ = 12;

//enemy_spawn_chance, spawns a enemy tile on one out of the number set
enemy_spawn_chance = 64;

grid_ = ds_grid_create(width_, height_);
ds_grid_set_region(grid_, 0, 0, width_, height_, VOID);

var _min_room_size = 4;
var _max_room_size = 16;
var _room_count = irandom_range(12, 16); // Generate between 12 to 16 rooms
_rooms = ds_list_create();

// Define spawn room size and position
var _spawn_room_width = 6;
var _spawn_room_height = 6;
var _spawn_room_x = (width_ div 2) - (_spawn_room_width div 2);
var _spawn_room_y = (height_ div 2) - (_spawn_room_height div 2);

// Create and add spawn room to grid and list
var _spawn_room = ds_map_create();
ds_map_add(_spawn_room, "_x", _spawn_room_x);
ds_map_add(_spawn_room, "_y", _spawn_room_y);
ds_map_add(_spawn_room, "width", _spawn_room_width);
ds_map_add(_spawn_room, "height", _spawn_room_height);
ds_map_add(_spawn_room, "connected_rooms", ds_list_create()); // Ensure this is always called when making new rooms
ds_list_add(_rooms, _spawn_room);

// func to find the nearest room from the current tile x,y
find_nearest_room = function(_rooms, _current_x, _current_y) {
    var min_distance = infinity;
    var nearest_room = undefined;
    
    for (var i = 0; i < ds_list_size(_rooms); i++) {
        var _room = ds_list_find_value(_rooms, i);
        var _room_x = ds_map_find_value(_room, "_x") + ds_map_find_value(_room, "width") div 2;
        var _room_y = ds_map_find_value(_room, "_y") + ds_map_find_value(_room, "height") div 2;
        
        // skip if it's the current room
        if (_room_x == _current_x && _room_y == _current_y) continue;

        // calculate distance to this room
        var _distance = point_distance(_current_x, _current_y, _room_x, _room_y);
        
        // update nearest room if this one is closer
        if (_distance < min_distance) {
            min_distance = _distance;
            nearest_room = _room;
        }
    }
    
    return nearest_room;
}

// func to get the minimum distance to the nearest room
min_distance_to_nearest_room = function(_rooms, _new_x, _new_y) {
    var min_distance = infinity;
    for (var i = 0; i < ds_list_size(_rooms); i++) {
        var _room = ds_list_find_value(_rooms, i);
        var _room_center_x = ds_map_find_value(_room, "_x") + ds_map_find_value(_room, "width") div 2;
        var _room_center_y = ds_map_find_value(_room, "_y") + ds_map_find_value(_room, "height") div 2;
        var _distance = point_distance(_new_x, _new_y, _room_center_x, _room_center_y);
        if (_distance < min_distance) {
            min_distance = _distance;
        }
    }
    return min_distance;
}
	
distance_to_room = function(_room, _x, _y) {
    var _room_center_x = ds_map_find_value(_room, "_x") + ds_map_find_value(_room, "width") div 2;
    var _room_center_y = ds_map_find_value(_room, "_y") + ds_map_find_value(_room, "height") div 2;
    
    // Calculate distance from (_x, _y) to the center of the spawn room
    return point_distance(_x, _y, _room_center_x, _room_center_y);
}


//func based loosly on the original level gen, creates a pseodo random path between two tile x, y pairs
create_path = function(start_x, start_y, end_x, end_y) {
    var _controller_x = start_x;
    var _controller_y = start_y;
    var _target_x = clamp(end_x, 1, width_ - 2); // Ensure target is within bounds
    var _target_y = clamp(end_y, 1, height_ - 2); // Ensure target is within bounds
    var _direction_change_odds = 1; // Odds of changing direction
    var _max_step = 500;
    var _curr_step = 0;

    while ((_controller_x != _target_x || _controller_y != _target_y) && _curr_step <= _max_step) {
        _curr_step++;
        var _dx = _target_x - _controller_x;
        var _dy = _target_y - _controller_y;
        var _move_horizontally = abs(_dx) > abs(_dy);

        if (irandom(1) < _direction_change_odds && abs(_dx) != abs(_dy)) {
            _move_horizontally = !_move_horizontally;
        }

        if (_move_horizontally && _dx != 0) {
            _controller_x += sign(_dx);
        } else if (_dy != 0) {
            _controller_y += sign(_dy);
        }

        _controller_x = clamp(_controller_x, 1, width_ - 2);
        _controller_y = clamp(_controller_y, 1, height_ - 2);

		if (grid_[# _controller_x, _controller_y] == VOID){
			grid_[# _controller_x, _controller_y] = FLOOR;
		}
		
        if (_controller_x == _target_x && _controller_y == _target_y) {
            break;
        }
    }
};

//used create_path() to create a path between two rooms
connect_rooms_with_hallway = function(_room1, _room2) {
	if (is_connected(_room1, _room2) || has_common_connection(_room1, _room2)) {
        return; // Stop if rooms are already connected or share a common connection
    }
    var _room1_x = ds_map_find_value(_room1, "_x") + ds_map_find_value(_room1, "width") div 2;
    var _room1_y = ds_map_find_value(_room1, "_y") + ds_map_find_value(_room1, "height") div 2;
    var _room2_x = ds_map_find_value(_room2, "_x") + ds_map_find_value(_room2, "width") div 2;
    var _room2_y = ds_map_find_value(_room2, "_y") + ds_map_find_value(_room2, "height") div 2;

    // Use the create_path function to dynamically create a path from room1 to room2
    create_path(_room1_x, _room1_y, _room2_x, _room2_y);
	var _room1_connections = ds_map_find_value(_room1, "connected_rooms");
    var _room2_connections = ds_map_find_value(_room2, "connected_rooms");
    ds_list_add(_room1_connections, _room2);
    ds_list_add(_room2_connections, _room1);
}

//func to check if two rooms are connected
is_connected = function(_room1, _room2) {
    var _room1_connections = ds_map_find_value(_room1, "connected_rooms");
    return ds_list_find_index(_room1_connections, _room2) != -1;
};

has_common_connection = function(_room1, _room2) {
    var _room1_connections = ds_map_find_value(_room1, "connected_rooms");
    var _room2_connections = ds_map_find_value(_room2, "connected_rooms");

    for (var i = 0; i < ds_list_size(_room1_connections); i++) {
        var connection = ds_list_find_value(_room1_connections, i);
        if (ds_list_find_index(_room2_connections, connection) != -1) {
            return true;  // Found a common connection
        }
    }
	
	for (var i = 0; i < ds_list_size(_room2_connections); i++) {
        var connection = ds_list_find_value(_room2_connections, i);
        if (ds_list_find_index(_room1_connections, connection) != -1) {
            return true;  // Found a common connection
        }
    }
    return false;  // No common connection found
};

//func that draw room connection
draw_room_connections = function(_room) {
    var _room_connections = ds_map_find_value(_room, "connected_rooms");
    var _room_center_x = ds_map_find_value(_room, "_x") + ds_map_find_value(_room, "width") / 2;
    var _room_center_y = ds_map_find_value(_room, "_y") + ds_map_find_value(_room, "height") / 2;

    for (var i = 0; i < ds_list_size(_room_connections); i++) {
        var _connected_room = ds_list_find_value(_room_connections, i);
        var _connected_center_x = ds_map_find_value(_connected_room, "_x") + ds_map_find_value(_connected_room, "width") / 2;
        var _connected_center_y = ds_map_find_value(_connected_room, "_y") + ds_map_find_value(_connected_room, "height") / 2;
        draw_line(_room_center_x * CELL_WIDTH, _room_center_y * CELL_HEIGHT, _connected_center_x * CELL_WIDTH, _connected_center_y*CELL_HEIGHT);
		//show_debug_message("drew connect line : "+ string(_room_center_x) + " : " + string(_room_center_y) + " : " + string(_connected_center_x) + " : " + string(_connected_center_y));
    }
};

//func to draw all room connection in all rooms
draw_all_room_connections = function(_rooms) {
    for (var i = 0; i < ds_list_size(_rooms); i++) {
        var _room = ds_list_find_value(_rooms, i);
        draw_room_connections(_room);
    }
};

//func to check isolated rooms and connect them to the nearest room
connect_isolated_rooms = function(_rooms) {
    var changes = true; // Flag to detect if any new connections were made

    while (changes) {
        changes = false; //assume no changes will be made this pass

        for (var i = 0; i < ds_list_size(_rooms); i++) {
            var _current_room = ds_list_find_value(_rooms, i);
            var _current_x = ds_map_find_value(_current_room, "_x");
            var _current_y = ds_map_find_value(_current_room, "_y");
            var _current_width = ds_map_find_value(_current_room, "width");
            var _current_height = ds_map_find_value(_current_room, "height");

            // checks if the current room is isolated using the is_room_isolated function
            if (is_room_isolated(_current_x, _current_y, _current_width, _current_height)) {
                var nearest_room = find_nearest_room(_rooms, _current_x + _current_width div 2, _current_y + _current_height div 2);
                if (nearest_room != undefined) {
					show_debug_message("connected rooms: " + string(_current_room) + " : "+ string(nearest_room))
                    connect_rooms_with_hallway(_current_room, nearest_room);
                    changes = true; // A connection was made, so changes happened
                }
            }
        }
    }
}


//func that checks the boundary of the room for outside connections
is_room_isolated = function(_x, _y, _width, _height) {
    //checks above and below the room
    for (var ix = _x; ix <= _x + _width; ix++) {
        if (grid_[# ix, _y - 1] == FLOOR || grid_[# ix, _y + _height + 1] == FLOOR) {
            return false; // Connection found above or below the room
        }
    }
    //checks to the left and right of the room
    for (var iy = _y; iy <= _y + _height; iy++) {
        if (grid_[# _x - 1, iy] == FLOOR || grid_[# _x + _width + 1, iy] == FLOOR) {
            return false; // Connection found on the left or right of the room
        }
    }
    return true; //no connection found, room is isolated
}
	

place_room = function(_room_type){
	var _room_placed = false;
    while (!_room_placed) {
        var _room_width = irandom_range(min_room_size, max_room_size);
        var _room_height = irandom_range(min_room_size, max_room_size);
        
        //ranges to keep rooms away from being out of bounds
        var _room_x = irandom_range(boundary_size_, width_ - _room_width - boundary_size_);
        var _room_y = irandom_range(boundary_size_, height_ - _room_height - boundary_size_);
		
		switch (_room_type) {
		    case "spawn_1":
				var _real_room_width = 5;
				var _real_room_height = 5;
		        var _real_room_x = _room_x;
				var _real_room_y = _room_y;
		        break;
			case "basic_1":
				var _real_room_width = _room_width;
				var _real_room_height = _room_height;
		        var _real_room_x = _room_x;
				var _real_room_y = _room_y;
		        break;
			case "mecha+spawn_1":
				var _real_room_width = 7;
				var _real_room_height = 7;
		        var _real_room_x = _room_x;
				var _real_room_y = _room_y;
		        break;
		    default:
		        var _real_room_width = _room_width;
				var _real_room_height = _room_height;
		        var _real_room_x = _room_x;
				var _real_room_y = _room_y;
		        break;
		}

        var _room_center_x = _real_room_x + _real_room_width div 2;
        var _room_center_y = _real_room_y + _real_room_height div 2;

        //checks if the room is close enough to another room
        if (min_distance_to_nearest_room(_rooms, _room_center_x, _room_center_y) <= min_space_distance_) {
            var _overlap = false;
            for (var j = 0; j < ds_list_size(_rooms); j++) {
                var _other = ds_list_find_value(_rooms, j);
                var _other_x = ds_map_find_value(_other, "_x");
                var _other_y = ds_map_find_value(_other, "_y");
                var _other_width = ds_map_find_value(_other, "width");
                var _other_height = ds_map_find_value(_other, "height");
                if (!(_real_room_x + _real_room_width + 4 < _other_x || _real_room_x > _other_x + _other_width + 4 ||
                    _real_room_y + _real_room_height + 4 < _other_y || _real_room_y > _other_y + _other_height + 4)) {
                    _overlap = true;
                    break;
                }
            }

            //adds room to grid if no overlap
            if (!_overlap) {
                var _room = ds_map_create();
				ds_map_add(_room, "_x", _real_room_x);
				ds_map_add(_room, "_y", _real_room_y);
				ds_map_add(_room, "width", _real_room_width);
				ds_map_add(_room, "height", _real_room_height);
				ds_map_add(_room, "connected_rooms", ds_list_create());
				ds_list_add(_rooms, _room);

                //marks room space on the grid
                for (var rx = _real_room_x; rx < _real_room_x + _real_room_width; rx++) {
                    for (var ry = _real_room_y; ry < _real_room_y + _real_room_height; ry++) {
                        grid_[# rx, ry] = FLOOR;
                    }
                }
				switch (_room_type) {
				    case "spawn_1":
						var center_x = _real_room_x + _real_room_width div 2;
			                var center_y = _real_room_y + _real_room_height div 2;
			                grid_[# center_x, center_y] = PLAYER_SPAWN;
				        break;
					case "mecha_spawn_1":
						 var center_x = _real_room_x + _real_room_width div 2;
			                var center_y = _real_room_y + _real_room_height div 2;
			                grid_[# center_x, center_y] = MECHA_SPAWN;
				        break;
				}
                _room_placed = true;
				connect_isolated_rooms(_rooms);
            }
        }
    }
		if (_room_placed) = true {
			return _room
		}
}

//room placement loop
player_spawn_room = place_room("spawn_1"); _room_count--;
place_room("basic_1"); _room_count--;
place_room("basic_1"); _room_count--;
place_room("basic_1"); _room_count--;
place_room("mecha_spawn_1"); _room_count--;
for (var i = 0; i < _room_count; i++) {
    place_room("basic_1")
}


// Number of random connections
var num_random_connections = irandom_range(1, ds_list_size(_rooms)/4);


//adds random connections
for (var j = 0; j < num_random_connections; j++) {
    var room_index1 = irandom(ds_list_size(_rooms) - 1);
    var room_index2 = irandom(ds_list_size(_rooms) - 1);
    while (room_index1 == room_index2) {  // Ensure different rooms
        room_index2 = irandom(ds_list_size(_rooms) - 1);
    }
    connect_rooms_with_hallway(ds_list_find_value(_rooms, room_index1), ds_list_find_value(_rooms, room_index2));
}


// --- original level gen
/*
//create the controller
var _controller_x = width_ div 2;
var _controller_y = height_ div 2;
var _controller_direction = irandom(3); // (3) == down
var _steps = 400; 
var _branch_steps = 900;

//odds of changing direction
var _direction_change_odds = 1; 

var _step_num = 0;

var _target_step = irandom(_steps)

var _branch_x = _controller_x;
var _branch_y = _controller_y;
*/

/*
var _branch_controller_x = _branch_x;
var _branch_controller_y = _branch_y;

var _branch_target_x = irandom(width_)
var _branch_target_y = irandom(height_)

grid_[# _branch_target_x, _branch_target_y] = BRANCH_END;
var _not_reach_end = true;

while (_not_reach_end){
	_step_num++;
	show_debug_message(string(_step_num))
	show_debug_message("Target step"+string(_target_step))
	if (_step_num >= _branch_steps){
		_not_reach_end = false;
	}
	//take current controller position, and sets it to a floor

	grid_[# _branch_controller_x, _branch_controller_y] = BRANCH_SEED;

	var _x_dist = _branch_target_x - _branch_controller_x;
	var _y_dist = _branch_target_y - _branch_controller_y;
	
	var _move_vert = 0;
	var _move_horz = 0;
	
	//randomize direction
	
		
		_controller_direction = irandom(2)-1;
		if (_controller_direction = 0){
			if (_y_dist > 0) {
				_move_vert = -1;
			} else {
				_move_vert = 1;
			}
			
			if (_x_dist > 0) {
				_move_horz = -1;
			} else {
				_move_horz = 1;
			}
		} 

	
	//move controller
	var _x_direction = lengthdir_y(1, _move_horz * 90);
	var _y_direction = lengthdir_y(1, _move_vert * 90);
	
	_branch_controller_x += _x_direction;
	_branch_controller_y += _y_direction;
	
	//make sure we don't go outside the grid
	if (_branch_controller_x < 2 || _branch_controller_x >= width_ -2){
		
		//instead of going forward once (out of the bounds), it takes us 2 tiles back. (x)
		_branch_controller_x += -_x_direction * 2;
	}
	
	if (_branch_controller_y < 2 || _branch_controller_y >= height_ -2){
		
		//instead of going forward once (out of the bounds), it takes us 2 tiles back. (y)
		_branch_controller_y += -_y_direction * 2;
	
	}
}
*/	

//--- What this does is create a copy of the skinny hallway gid to compare. Adds an FLOOR tile outline to it making eveything wider and more open
// copy the grid for checking
var grid_copy = ds_grid_create(width_, height_);
ds_grid_copy(grid_copy, grid_);

// loop for converting VOID tiles next to FLOOR tiles into FLOOR

for (var _y = 0; _y < height_; _y++) {
    for (var _x = 0; _x < width_; _x++) {
        // proceeds if the current tile is VOID in the original grid
        if (grid_copy[# _x, _y] == VOID) {
            // check neighboring tiles using the copied grid
            var isNextToFloor = false;
            for (var _ny = -1; _ny <= 1; _ny++) {
                for (var _nx = -1; _nx <= 1; _nx++) {
                    if (_nx == 0 && _ny == 0) continue; // skip the current tile itself
                    
                    var checkX = _x + _nx;
                    var checkY = _y + _ny;

                    // make sure we're not out of bounds
                    if (checkX >= 0 && checkX < width_ && checkY >= 0 && checkY < height_) {
                        if ((grid_copy[# checkX, checkY] == FLOOR )||(grid_copy[# checkX, checkY] == MECHA_SPAWN )||(grid_copy[# checkX, checkY] == BRANCH_SEED )){
                            isNextToFloor = true;
                            break;
                        }
                    }
                }
                if (isNextToFloor) break;
            }

            // if next to a FLOOR tile, convert in the original grid
            if (isNextToFloor) {
                grid_[# _x, _y] = FLOOR;
            }
        }
    }
}
// cleanup: destroy the copied grid after use to free up resources
ds_grid_destroy(grid_copy);


//--- What this does is create a copy of the skinny hallway gid to compare. Adds an WALL tile outline
// copy the grid for checking
var grid_copy = ds_grid_create(width_, height_);
ds_grid_copy(grid_copy, grid_);

// loop for converting VOID tiles next to FLOOR tiles into WALL
for (var _y = 0; _y < height_; _y++) {
    for (var _x = 0; _x < width_; _x++) {
        // proceeds if the current tile is VOID in the original grid
        if (grid_copy[# _x, _y] == VOID) {
            // check neighboring tiles using the copied grid
            var isNextToFloor = false;
            for (var _ny = -1; _ny <= 1; _ny++) {
                for (var _nx = -1; _nx <= 1; _nx++) {
                    if (_nx == 0 && _ny == 0) continue; // skip the current tile itself
                    
                    var checkX = _x + _nx;
                    var checkY = _y + _ny;

                    // make sure we're not out of bounds
                    if (checkX >= 0 && checkX < width_ && checkY >= 0 && checkY < height_) {
                        if (grid_copy[# checkX, checkY] == FLOOR) {
                            isNextToFloor = true;
                            break;
                        }
                    }
                }
                if (isNextToFloor) break;
            }

            // if next to a FLOOR tile, convert into WALLL in the original grid
            if (isNextToFloor) {
                grid_[# _x, _y] = WALL;
            }
        }
    }
}
// cleanup: destroy the copied grid after use to free up resources
ds_grid_destroy(grid_copy);

//draw grid
for (var _y = 1; _y < height_ -1; _y++){
	
	for (var _x = 1; _x < width_ -1; _x++){
		
		if(grid_[# _x, _y] == FLOOR){
			var _chance = irandom(enemy_spawn_chance)
			if (distance_to_room(player_spawn_room, _x, _y) >= 48){
				if (_chance < 4){
					grid_[# _x, _y] = ENEMY_SPAWN;
				}
			} else if (distance_to_room(player_spawn_room, _x, _y) >= 32){
				if (_chance < 2){
					grid_[# _x, _y] = ENEMY_SPAWN;
				}
			} else if (distance_to_room(player_spawn_room, _x, _y) >= 12){
				if (_chance < 1){
					grid_[# _x, _y] = ENEMY_SPAWN;
				}
			}
		}
	}
	
	for (var _x = 1; _x < width_ -1; _x++){
		
		if(grid_[# _x, _y] == FLOOR){
			tilemap_set(_wall_map_id, 1, _x, _y);
			
		} else if (grid_[# _x, _y] == BRANCH_SEED) {
			tilemap_set(_wall_map_id, 4, _x, _y);
			
		} else if (grid_[# _x, _y] == BRANCH_END) {
			tilemap_set(_wall_map_id, 4, _x, _y);
			
		} else if (grid_[# _x, _y] == MECHA_SPAWN) {
			tilemap_set(_wall_map_id, 3, _x, _y);
			
		} else if (grid_[# _x, _y] == PLAYER_SPAWN) {
			tilemap_set(_wall_map_id, 3, _x, _y);
			
		} else if (grid_[# _x, _y] == ENEMY_SPAWN) {
			tilemap_set(_wall_map_id, 1, _x, _y);
			
		} else {
			tilemap_set(_wall_map_id, 2, _x, _y);
			
		}
	}
}


// creates wall ojects on Wall tiles
for (var _y = 0; _y < height_; _y++) {
    for (var _x = 0; _x < width_; _x++) {
        if (grid_[# _x, _y] == WALL) {
			// calculates the actual room position based on the grid position
			var real_x = _x * CELL_WIDTH + CELL_WIDTH / 2;
            var real_y = _y * CELL_HEIGHT + CELL_HEIGHT / 2;

            // Create the wall object at this position
			//show_debug_message("Made wall")
            instance_create_layer(real_x, real_y, "Level", obj_wall);
        }
		if (grid_[# _x, _y] == MECHA_SPAWN) {
			// calculates the actual room position based on the grid position
			var real_x = _x * CELL_WIDTH + CELL_WIDTH / 2;
            var real_y = _y * CELL_HEIGHT + CELL_HEIGHT / 2;

            // Create the wall object at this position
			show_debug_message("Made Mecha")
            instance_create_layer(real_x, real_y, "Instances", obj_mecha_mount);
        }
		if (grid_[# _x, _y] == PLAYER_SPAWN) {
			// calculates the actual room position based on the grid position
			var real_x = _x * CELL_WIDTH + CELL_WIDTH / 2;
            var real_y = _y * CELL_HEIGHT + CELL_HEIGHT / 2;
			show_debug_message("Made player")
			obj_game_mgr.spawn_player(real_x, real_y)
        }
		if (grid_[# _x, _y] == ENEMY_SPAWN) {
			// calculates the actual room position based on the grid position
			var real_x = _x * CELL_WIDTH + CELL_WIDTH / 2;
            var real_y = _y * CELL_HEIGHT + CELL_HEIGHT / 2;
			show_debug_message("Made Enemy")
			instance_create_layer(real_x, real_y+12, "Instances", obj_enemy);
        }
    }
}