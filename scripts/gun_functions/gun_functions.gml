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
	global.items[6] = {
		num_: 6,
	    name: "Bounce Module",
		type: "Upgrade_Module",
	    info: "A Module that makes projectiles bounce off of walls"
	};
	global.items[7] = {
		num_: 7,
	    name: "Fire Rate Module",
		type: "Upgrade_Module",
	    info: "Module that makes your gun fire rate faster, max of five"
	};
	global.items[8] = {
		num_: 8,
	    name: "Speed Increase Module",
		type: "Upgrade_Module",
	    info: "Module that makes your gun fire faster projectiles"
	};
	global.items[9] = {
		num_: 9,
	    name: "Speed Decrease Module",
		type: "Upgrade_Module",
	    info: "Module that makes your gun fire slower projectiles"
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
        info: "A slow fire gun, bolt slugger for long-range sniping",
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
	
	global._primary_gun_tags = ds_list_create();
	global._secondary_gun_tags = ds_list_create();

    return global.mecha_guns;
}
	
function copy_gun(_index) {
    var original = global.guns[_index];
    var copy = {};

    // copy each trait
    copy.num_ = original.num_;
    copy.name = original.name;
    copy.type = original.type;
    copy.info = original.info;
    copy.fire_rate = original.fire_rate;
    copy.bullet_spread = original.bullet_spread;
    copy.bullet_speed = original.bullet_speed;
    copy.bullet_bounce = original.bullet_bounce;
    copy.bullet_lifespan = original.bullet_lifespan;
    copy.bullet_lifespan_rng = original.bullet_lifespan_rng;
    copy.projectile_spr = original.projectile_spr;
    copy.projectile_type = original.projectile_type;

    return copy;
}

function build_gun(_inventory) {
    _gun = find_gun_module(_inventory);
    show_debug_message(string(_gun));

    // Ensures the tag list is created and clears it each time this function is called
    if (!ds_exists(global._primary_gun_tags, ds_type_list)) {
        global._primary_gun_tags = ds_list_create();
    } else {
        ds_list_clear(global._primary_gun_tags);
    }

    // creates the tag list from the inventory
    for (var i = 0; i < array_length(_inventory); i++) {
        var _module = find_upgrade_module(_inventory, i);
        ds_list_add(global._primary_gun_tags, _module);
        show_debug_message("tag loop: " + string(i));
    }

    // copies the original gun properties
    var _projectile_original = global.guns[_gun];
    var _projectile_properties = copy_gun(_gun);
    var _num = 0;  // Counter for "FIRERATE+" tags

    // apply effects based on tags
    for (var i = 0; i < ds_list_size(global._primary_gun_tags); i++) {
        var _tag = ds_list_find_value(global._primary_gun_tags, i);
        switch (_tag) {
            case 6:
                //show_debug_message("BOUNCE TAG");
                _projectile_properties.bullet_bounce = true;
                break;
            case 7:
                //show_debug_message("FIRERATE +");
                _num++;  // Increment for each increase firerate tag
				if (_num < 6){
					_projectile_properties.fire_rate = _projectile_original.fire_rate -((_projectile_original.fire_rate/6) * _num);
				}
				break;
            case 8:
                //show_debug_message("SPEED +");
                _projectile_properties.bullet_speed += 10;
                break;
            case 9:
                //show_debug_message("SPEED -");
                _projectile_properties.bullet_speed -= 10;
                break;
        }
        show_debug_message("fire_rate num: " + string(_num));
    }

    global.mecha_guns.primary_gun = _gun;
    return _projectile_properties;
}


function find_gun_module(_inventory){
    for (var i = 0; i < array_length(_inventory); i++) {
        var item_id = _inventory[i];
        if ((item_id != -1)&&(item_id != 0)) { // checks if the slot is not empty
			show_debug_message("Item id:" + string(item_id));
            var item_info = global.items[item_id]; // get item information from the array
            if (item_info.type == "Gun_Module") {
				show_debug_message("Gun_Module found: " + string(item_info.num_));
                return item_info.num_;
            }
        }
    }
    return "No Gun Module found"; // Return default message if no gun module is found
}

function find_upgrade_module(_inventory, _slot){
	var item_id = _inventory[_slot];
    if ((item_id != -1)&&(item_id != 0)) { // checks if the slot is not empty
		var item_info = global.items[item_id]; // get item information from the array
		show_debug_message("Module item_info:" + string(item_id));
		if (item_info.type == "Upgrade_Module") {
			show_debug_message("Module name:" + string(item_info.name));
			return item_info.num_;
		}
	}
    return "No Gun Module found"; // Return default message if no gun module is found
}
	
function create_projectile( _x, _y, _projectile_vert_offset, _rot, _inventory, _cooldown, _add_xspeed, _add_yspeed)
{
	// Offsets for players gun position
	var _projectile_properties = build_gun(_inventory);
	
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
	_new_projectile.set_projectile(_projectile_properties.bullet_speed, _direction, _add_xspeed, _add_yspeed);
	
	
}