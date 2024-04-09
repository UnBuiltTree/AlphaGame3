

if (!surface_exists(light_surface)) {
    light_surface = surface_create(room_width, room_height);
    surface_set_target(light_surface);
    
	
    // Check if _spr_light_surface has been set and if the sprite exists
    if (_spr_light_surface != -1 && sprite_exists(_spr_light_surface)) {
        draw_sprite(_spr_light_surface, 0, 0, 0);
    }
    surface_reset_target();
}

var vx = 0;
var vy = 0;
var squish_factor = 0.75;

//-----------------------------
	surface_set_target(light_surface);
	//draw_clear(c_black);

	gpu_set_fog(true, c_white, 0, 1)

	//draws shadows for obj_enemy, obj_player, and obj_player_spawn.
	with (obj_player_human) {
		var radius = (sprite_get_width(sprite_index)/2+1)*12
		var sx = x-vx-1
		var sy = y-vy-2

		draw_ellipse(sx - radius, sy - radius* squish_factor, sx + radius, sy + radius * squish_factor, false);
	}
	with (obj_mecha) {
		var radius = (sprite_get_width(sprite_index)/2+1)*12
		var sx = x-vx-1
		var sy = y-vy-2

		draw_ellipse(sx - radius, sy - radius* squish_factor, sx + radius, sy + radius * squish_factor, false);
	}
	with (obj_mecha_mount) {
		var radius = (sprite_get_width(sprite_index)/2+1)*4
		var sx = x-vx-1
		var sy = y-vy-2
	    
		draw_ellipse(sx - radius, sy - radius* squish_factor, sx + radius, sy + radius * squish_factor, false);
	}
	

	gpu_set_fog(false, c_white, 0, 0);

	surface_reset_target();
	draw_set_alpha(light_alpha);
	// Draw the mask surface
	
	gpu_set_blendmode_ext(bm_inv_src_color, bm_src_alpha);
	
	//gpu_set_blendmode_ext(bm_src_color, bm_inv_src_color);
	draw_surface(light_surface, vx, vy);
	gpu_set_blendmode(bm_normal);

	//resets the draw alpha
	draw_set_alpha(1);

