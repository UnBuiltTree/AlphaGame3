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
		
	spread_counter = 0;
	spread_limit = 100;
	penetration_cooldown = 0;
	_spread = random_range(spread*-1, spread);
	_lifespan = lifespan + random_range(lifespan_rnd*-1, lifespan_rnd);

}

set_projectile = function(_speed, _direction, _add_xspeed, _add_yspeed){
	alarm[0] = _lifespan * 6
	direction = _direction + _spread;
	speed = _speed;
	hspeed += _add_xspeed;
	vspeed += _add_yspeed;
}


hit_nothing = function(){
	instance_destroy(self)
}