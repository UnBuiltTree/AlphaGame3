if (global.debug_mode){
	if (global.show_walls){
	draw_set_color(c_fuchsia);
    
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
	draw_set_color(c_white);
	}
}