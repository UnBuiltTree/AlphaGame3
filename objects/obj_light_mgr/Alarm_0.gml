if (sprite_exists(_spr_light_surface)) {
    sprite_delete(_spr_light_surface);
}

// Create a sprite from the surface
if (surface_exists(light_surface)) {
    _spr_light_surface = sprite_create_from_surface(light_surface, 0, 0, room_width, room_height, false, false, 0, 0);
	surface_free(light_surface);
}

alarm[0] = 16 * 100; // reset the alarm