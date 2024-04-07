/// @description Insert description here
// You can write your code in this editor
if (instance_exists(obj_mecha)){
	x = obj_mecha.x
	y = obj_mecha.y
} else if (instance_exists(obj_player_human)){
	x = obj_player_human.x
	y = obj_player_human.y
} else {
	x = room_width/2
	y = room_height/2
}

hspeed = 0;
vspeed = 0;
max_speed = 5;
acceleration = 0.5;

target_x = room_width/2;
target_y  = room_height/2;