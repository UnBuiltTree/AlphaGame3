var _width = 16;
var _x = camera_get_view_x(view_camera[0]) + 8
var _y = camera_get_view_y(view_camera[0]) + 8

if (instance_exists(obj_mecha)){
	var _curr_health = (obj_mecha.mecha_max_health - (obj_mecha.mecha_max_health - obj_mecha.mecha_curr_health))
	var _max_health = obj_mecha.mecha_max_health
	var _segments = _max_health / 20
	_curr_health = round(_curr_health/_segments)*_segments
} else if (instance_exists(obj_player_human)){
	var _curr_health = (obj_player_human.player_max_health - (obj_player_human.player_max_health - obj_player_human.player_curr_health))
	var _max_health = obj_player_human.player_max_health
	var _segments = _max_health / 20
	_curr_health = round(_curr_health/_segments)*_segments
} else {
	var _curr_health = 0;
	var _max_health = 0;
	var _segments = 0;
}

if ((_curr_health >= _max_health - _segments*2)&&(_curr_health > 0)){
	draw_set_color(c_lime);
} else if (_curr_health <= _segments*2) {
	draw_set_color(c_red);
} else {
	draw_set_color(c_green);
}

if (_curr_health <= _max_health){
	draw_rectangle(_x, _y, _x + _curr_health, _y + _width, false);
} else {
	draw_rectangle(_x, _y, _x + _max_health, _y + _width, false);
	draw_set_color(_flash_color);
	draw_rectangle(_x + _max_health + 1, _y, _x + _curr_health, _y + _width, false);
}


draw_set_color(c_dkgray);
draw_rectangle(_x, _y, _x + _max_health, _y + _width, true);
draw_set_color(c_white);