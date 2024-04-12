initialize_projectile  = function(_projectile_type, _direction, _add_xspeed, _add_yspeed){
	/*
	This stores infomation to build the projectile you want, while we do only have a
	single projectile object, the switch below modifyes that object to be thye projectile you want ~Weston
	speed; how fast the projectile moves
	spread; how accuarate the projectile is, the higher the number the lower the accuaracy
	sprite_index; what sprite is used for the projetile
	lifespan; how long the projectile last
	lifespan_rnd; added to lifespan to give randomness
	_explosion_type; if the projectile explodes at the end of its life this is what chages the type of explosion
	*/
	switch (_projectile_type) {
	    case "player_projectile":
			speed = 4;
			bounce = true;
			spread = 8;
	        sprite_index = spr_projectile;
			lifespan = 16;
			lifespan_rnd = 2;
	        break;
	    default:
	        speed = 4;
			bounce = false;
			spread = 8;
	        sprite_index = spr_projectile;
			lifespan = 16;
			lifespan_rnd = 2;
	        break;
	}
		
	spread_counter = 0;
	spread_limit = 100;
	_spread = random_range(spread*-1, spread);
	_lifespan = lifespan + random_range(lifespan_rnd*-1, lifespan_rnd);
	alarm[0] = _lifespan * 6
	direction = _direction
	hspeed += _add_xspeed;
	vspeed += _add_yspeed;
}


hit_nothing = function(){
	instance_destroy(self)
}

hit_level = function(_normal_x, _normal_y) {
    if (bounce) {
        // Reflect based on the surface normal
        if (_normal_x != 0) { // Reflect horizontally
            hspeed = hspeed * _normal_x; // Reflect and apply the direction of the normal
        }
        if (_normal_y != 0) { // Reflect vertically
            vspeed = vspeed * _normal_y; // Reflect and apply the direction of the normal
        }
	} else {
        instance_destroy(self);
	}
}