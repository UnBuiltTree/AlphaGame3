/// @description Insert description here
// You can write your code in this editor
draw_self()
if (global.debug_mode){
	draw_set_color(c_orange);
    
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
    
	draw_set_color(c_blue);
	
	draw_line(x, y+ycenter_offset, mouse_x, mouse_y)
	
	draw_circle(mouse_x, mouse_y, 4, false);
	
	draw_set_color(c_fuchsia);
	
	var _snap_angle = 15; // Angle that the red line snaps to
	var rotation = (round(point_direction(x, y+ycenter_offset, mouse_x, mouse_y)/_snap_angle)*_snap_angle); // Rotation angle in degrees

	var distance = sqrt(sqr(mouse_x - x) + sqr(mouse_y-ycenter_offset - y)); // Length of the line

	// Calculates the end point
	var _x = x + distance * dcos(rotation);
	
	var _y = y+ycenter_offset - distance * dsin(rotation); 

	// Draw the line
	draw_line(x, y+ycenter_offset, _x, _y);
	
	draw_set_color(c_white);
} else {
	draw_set_color(c_blue);
	
	draw_circle(mouse_x, mouse_y, 4, true);
	
	draw_set_color(c_white);
}