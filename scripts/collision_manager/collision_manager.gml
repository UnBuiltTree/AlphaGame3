// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function collision_manager(_bounce, _projectile) {
    // Detect collision with a wall object
    if (_bounce >= 1 && _bounce <= 4) { // Handles bounce cases
        // Horizontal collision check
        if (place_meeting(x + hspeed, y, obj_wall)) {
            collision = true;
            // Resolve horizontal overlap
            while (!place_meeting(x + sign(hspeed), y, obj_wall)) {
                x += sign(hspeed);
            }
			//---
			switch (_bounce) {
			    case 1:
					hspeed = -hspeed / 2;
			        break;
				case 2:
					hspeed = -hspeed;
			        break;
				case 3:
					hspeed = -hspeed / 2;
					vspeed = -vspeed / 2;
			        break;
				case 4:
					hspeed = -hspeed;
					vspeed = -vspeed;
			        break;
			}
			//---
        }

        // Vertical collision check
        if (place_meeting(x, y + vspeed, obj_wall)) {
            collision = true;
            // Resolve vertical overlap
            while (!place_meeting(x, y + sign(vspeed), obj_wall)) {
                y += sign(vspeed);
            }
            switch (_bounce) {
			    case 1:
					vspeed = -vspeed / 2;
			        break;
				case 2:
					vspeed = -vspeed;
			        break;
				case 3:
					hspeed = -hspeed / 2;
					vspeed = -vspeed / 2;
			        break;
				case 4:
					hspeed = -hspeed;
					vspeed = -vspeed;
			        break;
			}
        }
    } else if (_bounce <= 0 && _projectile) { // Handles projectile with no bounce
        // Horizontal projectile collision check
        if (place_meeting(x + hspeed, y, obj_wall)) {
            collision = true;
            instance_destroy(self);
        }

        // Vertical projectile collision check
        if (place_meeting(x, y + vspeed, obj_wall)) {
            collision = true;
            instance_destroy(self);
        }
    }
}