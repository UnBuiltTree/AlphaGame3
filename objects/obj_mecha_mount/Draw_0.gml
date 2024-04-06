
draw_self()
if (global.debug_mode){
	draw_set_color(c_blue);
    
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
    
	draw_set_color(c_white);
}