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
grid_ = ds_grid_create(width_, height_);
ds_grid_set_region(grid_, 0, 0, width_, height_, VOID);

//create the controller
var _controller_x = width_ div 2;
var _controller_y = height_ div 2;
var _controller_direction = irandom(3); // (3) == down
var _steps = 400; 
var _branch_steps = 100;

//odds of changing direction
var _direction_change_odds = 1; 

var _step_num = 0;

var _target_step = irandom(_steps)

repeat (_steps){
	_step_num++;
	show_debug_message(string(_step_num))
	show_debug_message("Target step"+string(_target_step))
	//take current controller position, and sets it to a floor
	if (_step_num == _target_step){
		grid_[# _controller_x, _controller_y] = BRANCH_SEED;
		var _branch_x = _controller_x;
		var _branch_y = _controller_y;
	} else {
		grid_[# _controller_x, _controller_y] = FLOOR;
	}
	
	//randomize direction
	if(irandom(_direction_change_odds) == _direction_change_odds){
		
		_controller_direction = irandom(3);
	}
	
	//move controller
	var _x_direction = lengthdir_x(1, _controller_direction * 90);
	var _y_direction = lengthdir_y(1, _controller_direction * 90);
	
	_controller_x += _x_direction;
	_controller_y += _y_direction;
	
	//make sure we don't go outside the grid
	if (_controller_x < 2 || _controller_x >= width_ -2){
		
		//instead of going forward once (out of the bounds), it takes us 2 tiles back. (x)
		_controller_x += -_x_direction * 2;
	}
	
	if (_controller_y < 2 || _controller_y >= height_ -2){
		
		//instead of going forward once (out of the bounds), it takes us 2 tiles back. (y)
		_controller_y += -_y_direction * 2;
	
	}
}

var _branch_controller_x = _branch_x;
var _branch_controller_y = _branch_y;

repeat (_branch_steps){
	_step_num++;
	show_debug_message(string(_step_num))
	show_debug_message("Target step"+string(_target_step))
	//take current controller position, and sets it to a floor
	if (_step_num == _target_step){
		grid_[# _branch_controller_x, _branch_controller_y] = BRANCH_SEED;
	} else {
		grid_[# _branch_controller_x, _branch_controller_y] = FLOOR;
	}
	
	//randomize direction
	if(irandom(_direction_change_odds) == _direction_change_odds){
		
		_controller_direction = irandom(3);
	}
	
	//move controller
	var _x_direction = lengthdir_x(1, _controller_direction * 90);
	var _y_direction = lengthdir_y(1, _controller_direction * 90);
	
	_controller_x += _x_direction;
	_controller_y += _y_direction;
	
	//make sure we don't go outside the grid
	if (_controller_x < 2 || _controller_x >= width_ -2){
		
		//instead of going forward once (out of the bounds), it takes us 2 tiles back. (x)
		_controller_x += -_x_direction * 2;
	}
	
	if (_controller_y < 2 || _controller_y >= height_ -2){
		
		//instead of going forward once (out of the bounds), it takes us 2 tiles back. (y)
		_controller_y += -_y_direction * 2;
	
	}
}

grid_[# _controller_x, _controller_y] = MECHA_SPAWN;
	
ds_grid_set_region(grid_, width_/2+3, height_/2+3, width_/2-3, height_/2-3, FLOOR);
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
                        if ((grid_copy[# checkX, checkY] == FLOOR )||(grid_copy[# checkX, checkY] == MECHA_SPAWN )){
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
			tilemap_set(_wall_map_id, 1, _x, _y);
			
		} else if (grid_[# _x, _y] == BRANCH_SEED) {
			tilemap_set(_wall_map_id, 4, _x, _y);
			
		} else if (grid_[# _x, _y] == MECHA_SPAWN) {
			tilemap_set(_wall_map_id, 3, _x, _y);
			
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
    }
}
