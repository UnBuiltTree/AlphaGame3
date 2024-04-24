
//draw_self()
draw_sprite(spr_mecha_leg_dn_walk, 0, x, y)
draw_sprite(spr_torso, torso_dir, x, y - 10)
if (global.debug_mode){
	draw_set_color(c_blue);
    
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
    
	draw_set_color(c_white);
}