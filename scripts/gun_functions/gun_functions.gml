// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function obj_player_gun(){
	
}

//func is used to create the table of items.
function create_item_table(){
	global.items = [];

	global.items[1] = {
		num_: 1,
	    name: "Player_Submachine_gun",
		type: "Gun_Module",
	    info: "A rapid fire machine gun for sustained close quarters combat"
	};
	global.items[2] = {
		num_: 2,
	    name: "Player_Assault_gun",
		type: "Gun_Module",
	    info: "An auto fire gun for sustained mid-range combat"
	};
	global.items[3] = {
		num_: 3,
	    name: "Player_AntiMat_gun",
		type: "Gun_Module",
	    info: "A single fire gun, bolt slugger for long-range sniping"
	};
	global.items[4] = {
		num_: 4,
	    name: "Player_Plasma_gun",
		type: "Gun_Module",
	    info: "A rapid fire energy weapon, usefull for close-range crowd control"
	};

	// add more items and modules here other items

}

//func used to create the table of gun and their traits.
function create_gun_table() {
    global.guns = [];

    global.guns[1] = {
		num_: 1,
        name: "Player_Submachine_gun",
        type: "Gun_Module",
        info: "A rapid fire machine gun for sustained close quarters combat",
        fire_rate: 10, 
        bullet_spread: 5,
        bullet_speed: 5,
		bullet_bounce: false,
		bullet_lifespan: 16,
		bullet_lifespan_rng: 2,
		projectile_spr: spr_projectile_small,
        projectile_type: "small_bullet"
    };

    global.guns[2] = {
		num_: 2,
        name: "Player_Assault_gun",
        type: "Gun_Module",
        info: "An auto fire gun for sustained mid-range combat",
        fire_rate: 20,
        bullet_spread: 3,
        bullet_speed: 7,
		bullet_bounce: false,
		bullet_lifespan: 16,
		bullet_lifespan_rng: 2,
		projectile_spr: spr_projectile_big,
        projectile_type: "medium_bullet"
    };

    global.guns[3] = {
		num_: 3,
        name: "Player_AntiMat_gun",
        type: "Gun_Module",
        info: "A single fire gun, bolt slugger for long-range sniping",
        fire_rate: 50,
        bullet_spread: 1,
        bullet_speed: 10,
		bullet_bounce: false,
		bullet_lifespan: 16,
		bullet_lifespan_rng: 2,
		projectile_spr: spr_projectile_big,
        projectile_type: "high_impact_bullet"
    };

    global.guns[4] = {
		num_: 4,
        name: "Player_Plasma_gun",
        type: "Gun_Module",
        info: "A rapid fire energy weapon, useful for close-range crowd control",
        fire_rate: 8,
        bullet_spread: 4,
        bullet_speed: 3,
		bullet_bounce: true,
		bullet_lifespan: 16,
		bullet_lifespan_rng: 2,
		projectile_spr: spr_projectile_plasma,
        projectile_type: "plasma_blast"
    };
}
	
function initialize_player_guns() {
    global.mecha_guns = {
        primary_gun: 2,
        secondary_gun: 3
    };

    return global.mecha_guns;
}

function modify_gun(player, gun_type, attribute, _set_attribute_as) {
    if (gun_type == "primary" && player.primary_gun != undefined) {
        player.primary_gun[attribute] = _set_attribute_as;
        show_debug_message("Primary gun upgraded: " + attribute + " increased by " + string(increment));
    } else if (gun_type == "secondary" && player.secondary_gun != undefined) {
        player.secondary_gun[attribute] = _set_attribute_as;
        show_debug_message("Secondary gun upgraded: " + attribute + " increased by " + string(increment));
    } else {
        show_debug_message("Upgrade failed");
    }
}

function build_gun(_inventory) {
	_gun = find_gun_module(_inventory);
	show_debug_message(string(_gun))
	global.mecha_guns.primary_gun = _gun;
	//obj_mecha._mecha_guns._gun_type
}

function find_gun_module(_inventory){
    for (var i = 0; i < array_length(_inventory); i++) {
        var item_id = _inventory[i];
        if ((item_id != -1)&&(item_id != 0)) { // checks if the slot is not empty
			show_debug_message("Item id:" + string(item_id));
            var item_info = global.items[item_id]; // get item information from the array
            if (item_info.type == "Gun_Module") {
                return item_info.num_;
            }
        }
    }
    return "No Gun Module found"; // Return default message if no gun module is found
}
	
function create_projectile( _x, _y, _projectile_vert_offset, _rot, _gun_type, _cooldown, _add_xspeed, _add_yspeed)
{
	// Offsets for players gun position
	var _projectile_properties = global.guns[_gun_type];
	_projectile_offset = 0;
	
	if (_projectile_properties == undefined) {
        show_debug_message("Gun type properties not found: " + _gun_type);
        return;
    }
	
	// Sets new postions from adjusted positions and players position
	var _projectile_pos_x = _x
	var _projectile_pos_y = _y + _projectile_vert_offset
	var _spawn_distance = 10;
	//var _direction = point_direction(_projectile_pos_x, _projectile_pos_y, mouse_x, mouse_y)
	var _direction = _rot
	
	_projectile_pos_x += lengthdir_x(_spawn_distance, _direction);
    _projectile_pos_y += lengthdir_y(_spawn_distance, _direction);

	// Creates new player projectile from the new positions
	var _new_projectile = instance_create_layer(_projectile_pos_x, _projectile_pos_y, "Projectiles", obj_projectile);
    _new_projectile.owner = self;	
	_new_projectile.initialize_projectile(_projectile_properties.projectile_type, _direction, _add_xspeed, _add_yspeed);
	_new_projectile.speed = _projectile_properties.bullet_speed;
	_new_projectile.bounce = _projectile_properties.bullet_bounce;
	_new_projectile.spread = _projectile_properties.bullet_spread;
	_new_projectile.sprite_index = _projectile_properties.projectile_spr;
	_new_projectile.lifespan = _projectile_properties.bullet_lifespan;
	_new_projectile.lifespan_rnd = _projectile_properties.bullet_lifespan_rng;
	switch (_cooldown) {
	    case "gun_one_cooldown":
	        global.gun_one_cooldown = _projectile_properties.fire_rate;
	        break;
		case "gun_two_cooldown":
	        global.gun_two_cooldown = _projectile_properties.fire_rate;
	        break;
	}
	
	
}