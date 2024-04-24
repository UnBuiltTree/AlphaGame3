/// @description Insert description here
// You can write your code in this editor
//draw_self()
if (walking){
	draw_sprite(walk_spr, _frame, x, y)
} else {
	draw_sprite(walk_spr, 0, x, y)
}
var rotation = (point_direction(x, y+ycenter_offset, mouse_x, mouse_y));
if rotation < 45 {draw_sprite(torso_spr, 0, x, y - 10)}
else if rotation < 135 {draw_sprite(torso_spr, 1, x, y - 10)}
else if rotation < 225 {draw_sprite(torso_spr, 2, x, y - 10)}
else if rotation < 315 {draw_sprite(torso_spr, 3, x, y - 10)}
else {draw_sprite(torso_spr, 0, x, y - 10)}

	
if (global.debug_mode){
	draw_set_color(c_orange);
    
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
    
	draw_set_color(c_blue);
	
	draw_line(x, y+ycenter_offset, mouse_x, mouse_y)
	
	//draw_circle(mouse_x, mouse_y, 4, false);
	
	draw_set_color(c_fuchsia);
	
	var _snap_angle = 15; // Angle that the red line snaps to
	var rotation = (round(point_direction(x, y+ycenter_offset, mouse_x, mouse_y)/_snap_angle)*_snap_angle); // Rotation angle in degrees

	var distance = sqrt(sqr(mouse_x - x) + sqr(mouse_y-ycenter_offset - y)); // Length of the line

	// Calculates the end point
	var _x = x + distance * dcos(rotation);
	
	var _y = y+ycenter_offset - distance * dsin(rotation); 

	// Draw the line
	draw_line(x, y+ycenter_offset, _x, _y);
	
	draw_set_color(c_green);
	
	var rotation = direction

	var distance = speed * 12 // Length of the line
	
	var _x = x + distance * dcos(rotation);
	
	var _y = y+ycenter_offset - distance * dsin(rotation); 

	// Draw the line
	draw_line(x, y+ycenter_offset, _x, _y);
	
	draw_set_color(c_white);
	
} else {
	draw_set_color(c_blue);
	
	//draw_circle(mouse_x, mouse_y, 4, true);
	draw_sprite_ext(spr_crosshair, 0, mouse_x, mouse_y, 1, 1, 0, c_blue, 1)
	
	draw_set_color(c_white);
}