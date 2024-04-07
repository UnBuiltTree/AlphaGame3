//different level every play
randomize();

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

//odds of changing direction
var _direction_change_odds = 1; 

repeat (_steps){
	
	//take current controller position, and sets it to a floor
	grid_[# _controller_x, _controller_y] = FLOOR;
	
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

//draw grid
for (var _y = 1; _y < height_ -1; _y++){
	
	for (var _x = 1; _x < width_ -1; _x++){
		
		if(grid_[# _x, _y] == FLOOR){
			
			tilemap_set(_wall_map_id, 1, _x, _y);
		}
	}
}
	