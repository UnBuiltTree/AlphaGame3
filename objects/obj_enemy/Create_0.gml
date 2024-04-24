enemy_initialize = function(){
	enemy_level = 1;
	enemy_curr_health = 100;
	enemy_max_health = 100;
	//drop_ = false;
	drop_ = true;
	var _chance = irandom(5)
	if (_chance = 1){
		drop_ = true;
	}
}
//-----
walking_sprite = -1;
fallback_sprite = spr_enemy
dmg = false;

randomStateTimer = 0;
randomStateMaxTimer = 100;

grv=0.5;
vspd=1;
hspd=1;

direct = choose("left", "right", "up","down");
alarm[0] = 60;

sprite = spr_enemy_small_dn
//frame looping alarm
frame = 0;
alarm[1] = 6;

state = eState.WANDERING;
isRangedAttacking = false;
isMeleeAttacking = false;



/*
if(sprite_exists(walking_sprite)) {
	sprite_index = walking_sprite;
} else {
	sprite_index = fallback_sprite;
}
*/

enum eState {
	IDLE,
	ATTACKING_MELEE,
	ATTACKING_RANGED,
	HUNTING,
	WANDERING,
}

//-----

enemy_initialize();