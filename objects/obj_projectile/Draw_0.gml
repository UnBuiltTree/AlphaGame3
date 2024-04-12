if (global.debug_mode)
{
    draw_set_color(c_orange);
    
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
    
    draw_set_color(c_white);
}

image_angle = round(direction/15)*15-90;

draw_self()