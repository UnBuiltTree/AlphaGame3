if(!surface_exists(shadow_surface)){
	shadow_surface = surface_create(room_width, room_height);
}

var vx = camera_get_view_x(0);
var vy = camera_get_view_y(0);
var squish_factor = 0.75;

//-----------------------------
if (!global.hide_shadows){
	surface_set_target(shadow_surface);
	draw_clear_alpha(c_black, 0);

	gpu_set_fog(true, c_black, 0, 1)

	//draws shadows for obj_enemy, obj_player, and obj_player_spawn.
	with (obj_player_human) {
		var radius = sprite_get_width(sprite_index)/2+1
		var sx = x-vx-1
		var sy = y-vy-2

		draw_ellipse(sx - radius, sy - radius* squish_factor, sx + radius, sy + radius * squish_factor, false);
	}
	with (obj_mecha) {
		var radius = sprite_get_width(sprite_index)/2+1
		var sx = x-vx-1
		var sy = y-vy-2

		draw_ellipse(sx - radius, sy - radius* squish_factor, sx + radius, sy + radius * squish_factor, false);
	}
	with (obj_mecha_mount) {
		var radius = sprite_get_width(sprite_index)/2+1
		var sx = x-vx-1
		var sy = y-vy-2
	    
		draw_ellipse(sx - radius, sy - radius* squish_factor, sx + radius, sy + radius * squish_factor, false);
	}
	

	gpu_set_fog(false, c_white, 0, 0);

	surface_reset_target();

	//this is the alpha for the shadows
	draw_set_alpha(sdw_alpha);

	draw_surface(shadow_surface, vx, vy);

	//resets the draw alpha
	draw_set_alpha(1);
}/// @description Insert description here
// You can write your code in this editor
