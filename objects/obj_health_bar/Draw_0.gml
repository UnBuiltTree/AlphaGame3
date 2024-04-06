var _width = 16;

if (instance_exists(obj_player)){
	var _curr_health = (obj_player.player_max_health - (obj_player.player_max_health - obj_player.player_curr_health))
	var _max_health = obj_player.player_max_health
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
	draw_rectangle(x, y, x + _curr_health, y + _width, false);
} else {
	draw_rectangle(x, y, x + _max_health, y + _width, false);
	draw_set_color(_flash_color);
	draw_rectangle(x + _max_health + 1, y, x + _curr_health, y + _width, false);
}


draw_set_color(c_dkgray);
draw_rectangle(x, y, x + _max_health, y + _width, true);
draw_set_color(c_white);