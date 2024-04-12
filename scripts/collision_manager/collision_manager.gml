// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function collision_manager(_bounce){
	// detect collision with a wall object
	if(_bounce){
		if (place_meeting(x + hspeed, y, obj_wall)) {
			collision = true;
			hspeed = hspeed/2
		    // resolve horizontal overlap
		    while (!place_meeting(x + sign(hspeed), y, obj_wall)) {
		        x += sign(hspeed);
		    }
		    hspeed = -hspeed; // Invert horizontal speed after resolving overlap
		}

		if (place_meeting(x, y + vspeed, obj_wall)) {
			collision = true;
			vspeed = vspeed/2
		    // resolve vertical overlap
		    while (!place_meeting(x, y + sign(vspeed), obj_wall)) {
		        y += sign(vspeed);
		    }
		    vspeed = -vspeed; // Invert vertical speed after resolving overlap
		}
	}
}