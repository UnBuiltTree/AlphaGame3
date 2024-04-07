
if (instance_exists(obj_mecha)){
	target_x = obj_mecha.x
	target_y = obj_mecha.y
} else if (instance_exists(obj_player_human)){
	target_x = obj_player_human.x
	target_y = obj_player_human.y
} else {
	target_x = room_width/2
	target_y = room_height/2
}

// Calculate distance and direction towards the target
var dx = target_x - x;
var dy = target_y - y;
var distance = point_distance(x, y, target_x, target_y);
var _direction = point_direction(x, y, target_x, target_y);

// Calculate speed based on distance
var _speed = min(max_speed, distance / 10);

// Calculate target speeds in each direction
var target_hspeed = lengthdir_x(_speed, _direction);
var target_vspeed = lengthdir_y(_speed, _direction);

// Smoothly adjust current speed towards target speed
hspeed += (target_hspeed - hspeed) * acceleration;
vspeed += (target_vspeed - vspeed) * acceleration;

// Optional: Stop the object if it is very close to the target to prevent jittering
if (distance < 2) {
    hspeed = 0;
    vspeed = 0;
}