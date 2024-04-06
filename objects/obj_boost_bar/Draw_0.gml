var _width = 8;

if (instance_exists(obj_mecha)){
	var _boost_value = (obj_mecha.boost_cooldown - obj_mecha._boost_cooldown)
	var _boost_max = obj_mecha.boost_cooldown
	var _segments = _boost_max / 8
	_boost_value= round(_boost_value/_segments)*_segments
} else if (instance_exists(obj_player_human)){
	var _boost_value = (obj_player_human.boost_cooldown - obj_player_human._boost_cooldown)
	var _boost_max = obj_player_human.boost_cooldown
	var _segments = _boost_max / 8
	_boost_value= round(_boost_value/_segments)*_segments
} else {
	var _boost_value = 0;
	var _boost_max = 0;
	var _segments = 0;
}

if ((_boost_value >= _boost_max)&&(_boost_value > 0)){
	draw_set_color(c_orange);
} else {
	draw_set_color(c_red);
}
    
draw_rectangle(x, y, x + _boost_value, y + _width, false);

draw_set_color(c_dkgray);
draw_rectangle(x, y, x + _boost_max, y + _width, true);
draw_set_color(c_white);