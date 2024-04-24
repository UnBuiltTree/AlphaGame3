var _knock_back = 16;
if (penetrative_value < 0){
	instance_destroy(self)
	other.hspeed += hspeed/_knock_back
	other.vspeed += vspeed/_knock_back
	other.enemy_curr_health -= damage;
	other.dmg = true;
} else {
	if (penetration_cooldown <= 0){
		penetrative_value--;
		penetration_cooldown = 16;
		other.hspeed += hspeed/(_knock_back*4)
		other.vspeed += vspeed/(_knock_back*4)
		other.enemy_curr_health -= damage;
		other.dmg = true;
	}
}