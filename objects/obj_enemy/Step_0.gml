collision_manager(1, false);

if (enemy_curr_health <= 0){
	if (drop_){
		create_item(random_item(), x - 8, y - 16);
	}
	instance_destroy(self);
}

//-----


if(direct == "left") {
	//direction = 270;
	//image_xscale = abs(image_xscale);
	image_xscale = 1
	
	if(state == eState.WANDERING /*|| state == eState.HUNTING*/) {
		hspeed = -1;	
	} else if(state == eState.IDLE /*|| state == eState.ATTACKING_MELEE ||  state == eState.ATTACKING_RANGED*/) {
		hspeed = 0;
	}
	
} 
if(direct == "right") {
	//direction = 90;
	//image_xscale = -abs(image_xscale);
	
	if(state == eState.WANDERING /*|| state == eState.HUNTING*/) {
		hspeed = 1;	
	} else if(state == eState.IDLE /*|| state == eState.ATTACKING_MELEE ||  state == eState.ATTACKING_RANGED*/) {
		hspeed = 0;
	}
	
}//added code
if(direct == "up") {
	//direction = 180;
	//image_xscale = -abs(image_xscale);
	
	if(state == eState.WANDERING /*|| state == eState.HUNTING*/) {
		vspeed = 1;	
	} else if(state == eState.IDLE /*|| state == eState.ATTACKING_MELEE ||  state == eState.ATTACKING_RANGED*/) {
		vspeed = 0;
	}
	
}
if(direct == "down") {
	//image_xscale = -abs(image_xscale);
	
	if(state == eState.WANDERING /*|| state == eState.HUNTING*/) {
		vspeed = -1;	
	} else if(state == eState.IDLE /*|| state == eState.ATTACKING_MELEE ||  state == eState.ATTACKING_RANGED*/) {
		vspeed = 0;
	}
	
}

if hspeed < 0 {sprite = spr_enemy_small_lf; image_xscale = 1};
if hspeed > 0 {sprite = spr_enemy_small_rt; image_xscale = -1};
if vspeed < 0 {sprite = spr_enemy_small_up; image_xscale = 1};
if vspeed > 0 {sprite = spr_enemy_small_dn; image_xscale = 1}


collision_manager(1, false);

/*
if(place_meeting(x + hspeed, y , obj_wall)) {
	if(direct == "left") {
		direct = "right";
	} else {
		direct = "left";	
	}
} 
if(place_meeting(x, y + vspeed, obj_wall)) { //added code
	if(direct == "down"){
		direct = "up";
	} else {
		direct = "down";
	}

}


if(!collision_line(x - sprite_width, y, x + sprite_width, y, obj_wall, false, true)) {
	if(direct == "left") {
		direct = "right";	
	} else {
		direct = "left";
	}
}
if(!collision_line(x, y - sprite_height, x, y + sprite_width, obj_wall, false, true)) { //added code
	if(direct == "down"){
		direct = "up";
	} else {
		direct = "down";
	}
}


//vspd+=grv; 
//hspd+=grv; <-- I added this

*/

/* 
if (place_meeting(x, y+vspd, obj_wall)){ commented this stuff out because I don't know if its needed

	while (abs(vspd) > 0.1) {
		vspd *= 0.1
		if (!place_meeting(x, y + vspd, obj_wall)) y += vspd
	}
	
    vspd=0.0;
}*/

if(randomStateTimer <= 0) {
	
	if(state == eState.WANDERING && irandom_range(0,2) >= 2) {
		state = eState.IDLE;
	} else if(state == eState.IDLE && irandom_range(0,7) >= 1) {
		state = eState.WANDERING;
	} 
	
	randomStateTimer = irandom_range(80, randomStateMaxTimer);
} else {
	randomStateTimer--;	
}

/*
if(isPlayerOnSamePlatform && state != eState.ATTACKING_RANGED && state != eState.ATTACKING_MELEE) {
	state = eState.HUNTING;
} else if(!isPlayerOnSamePlatform && state == eState.HUNTING) {
	state = eState.WANDERING;
}
*/