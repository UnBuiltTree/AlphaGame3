/// @description Insert description here
// You can write your code in this editor
if (dmg){
	draw_self()
	dmg = false;
}
draw_sprite(sprite, frame, x, y-10)

if (global.debug_mode){
	draw_set_color(c_orange);
    
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
	
	draw_set_color(c_white);
}