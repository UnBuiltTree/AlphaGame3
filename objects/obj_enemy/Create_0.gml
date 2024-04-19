enemy_initialize = function(){
	enemy_level = 1;
	enemy_curr_health = 100;
	enemy_max_health = 100;
	drop_ = false;
	var _chance = irandom(5)
	if (_chance = 1){
		drop_ = true;
	}
}

enemy_initialize();