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
	global.items[5] = {
		num_: 5,
	    name: "NULL_WIP",
		type: "Gun_Module",
	    info: "TO BE MADE"
	}
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
	global.items[10] = {
		num_: 10,
	    name: "Dead shot",
		type: "Upgrade_Module",
	    info: "Module that makes your projectiles hit on impact. No bounce"
	};
	global.items[11] = {
		num_: 11,
	    name: "Perfect Bounce",
		type: "Upgrade_Module",
	    info: "Module that makes your projectiles bounce off of walls losing no momentum."
	};
	global.items[12] = {
		num_: 12,
	    name: "Penetrative",
		type: "Upgrade_Module",
	    info: "Module that makes your projectiles penetrate through enemies"
	};
	global.items[13] = {
		num_: 13,
	    name: "Return Bounce",
		type: "Upgrade_Module",
	    info: "Module that makes your projectiles bounce off of walls directly back to where they came from"
	};

	// add more items and modules here other items

}

//func used to create the table of gun and their traits.
function create_gun_table() {
    global.guns = [];
	
	global.guns[0] = {
		num_: 0,
        name: "Player_default_gun",
        type: "Gun_Module",
        info: "Puny",
        fire_rate: 40, 
        bullet_spread: 12,
        bullet_speed: 3,
		bullet_bounce: 0,
		penetrative_value: 0,
		bullet_lifespan: 15,
		bullet_lifespan_rng: 5,
		bullet_damage : 8,
		projectile_spr: spr_projectile_small,
        projectile_type: "small_bullet"
    };

    global.guns[1] = {
		num_: 1,
        name: "Player_Submachine_gun",
        type: "Gun_Module",
        info: "A rapid fire machine gun for sustained close quarters combat",
        fire_rate: 10, 
        bullet_spread: 10,
        bullet_speed: 5,
		bullet_bounce: 0,
		penetrative_value: 0,
		bullet_lifespan: 16,
		bullet_lifespan_rng: 2,
		bullet_damage : 8,
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
		bullet_bounce: 0,
		penetrative_value: 0,
		bullet_lifespan: 16,
		bullet_lifespan_rng: 2,
		bullet_damage : 16,
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
		bullet_bounce: 0,
		penetrative_value: 1,
		bullet_lifespan: 16,
		bullet_lifespan_rng: 2,
		bullet_damage : 32,
		projectile_spr: spr_projectile_big,
        projectile_type: "high_impact_bullet"
    };

    global.guns[4] = {
		num_: 4,
        name: "Player_Plasma_gun",
        type: "Gun_Module",
        info: "A rapid fire energy weapon, useful for close-range crowd control",
        fire_rate: 6,
        bullet_spread: 12,
        bullet_speed: 3,
		bullet_bounce: 1,
		penetrative_value: 0,
		bullet_lifespan: 16,
		bullet_lifespan_rng: 2,
		bullet_damage : 8,
		projectile_spr: spr_projectile_plasma,
        projectile_type: "plasma_blast"
    };
}
	
function random_item(){
	var _num = irandom_range(1,12)
	if (_num < 4){_num = _num + 1};
	return _num
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
	copy.penetrative_value = original.penetrative_value;
    copy.bullet_lifespan = original.bullet_lifespan;
    copy.bullet_lifespan_rng = original.bullet_lifespan_rng;
	copy.bullet_damage = original.bullet_damage;
    copy.projectile_spr = original.projectile_spr;
    copy.projectile_type = original.projectile_type;

    return copy;
}

function build_gun(_inventory) {
    _gun = find_gun_module(_inventory);
	if (_gun == -1) {
        _gun = 0;
        //show_debug_message("No gun module found, setting gun to 0.");
		var _projectile_properties = copy_gun(_gun);
        global.mecha_guns.primary_gun = _gun;
		return _projectile_properties;
    }
    //show_debug_message(string(_gun));

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
        //show_debug_message("tag loop: " + string(i));
    }

    // copies the original gun properties
    var _projectile_original = global.guns[_gun];
    var _projectile_properties = copy_gun(_gun);
    var _fire_rate_num = 0;  // Counter for "FIRERATE+" tags
	var _plus_speed_num = 0;  // Counter for "FIRERATE+" tags
	var _minus_speed_num = 0;  // Counter for "FIRERATE+" tags
	var _num_bullet_spread = 0;
	if (_projectile_properties.bullet_bounce = 1){
		var _bounce_type = 1;
	} else {
		var _bounce_type = 0;
	}
	var _penetrative_num = 0;
	

    // apply effects based on tags
    for (var i = 0; i < ds_list_size(global._primary_gun_tags); i++) {
        var _tag = ds_list_find_value(global._primary_gun_tags, i);
        switch (_tag) {
            case 6:
                //show_debug_message("BOUNCE TAG");
				if (_bounce_type == 0){_bounce_type = 1};
				_num_bullet_spread += 2;
                break;
            case 7:
                //show_debug_message("FIRERATE +");
                _fire_rate_num++;  // Increment for each increase firerate tag
				if (_fire_rate_num < 6){
					_num_bullet_spread += 1;
					_projectile_properties.fire_rate = _projectile_original.fire_rate -((_projectile_original.fire_rate/6) * _fire_rate_num);
				}
				break;
            case 8:
                //show_debug_message("SPEED +");
				_num_bullet_spread+=1;
				_plus_speed_num++;
                _projectile_properties.bullet_speed = _projectile_original.bullet_speed +((_projectile_original.bullet_speed/2) * _plus_speed_num)-((_projectile_original.bullet_speed/4) * _minus_speed_num);
                break;
            case 9:
                //show_debug_message("SPEED -");
				_minus_speed_num++;
				_num_bullet_spread-=1;
				if (_minus_speed_num < 4){
					_projectile_properties.bullet_speed = _projectile_original.bullet_speed -((_projectile_original.bullet_speed/4) * _minus_speed_num)+((_projectile_original.bullet_speed/2) * _plus_speed_num);
				} else {
					_projectile_properties.bullet_speed = 0.25;
				}
				break;
			case 10:
				if (_bounce_type >= 0){_bounce_type = -1};
				break;
			case 11:
				if (_bounce_type <= 1 && _bounce_type != -1){_bounce_type = 2}
				else if (_bounce_type == 3){_bounce_type = 4};
				break;
			case 12:
				_penetrative_num++;
				break;
			case 13:
				if (_bounce_type == 2){_bounce_type = 4}
				else if (_bounce_type != -1){_bounce_type = 3};
				break;
        }
		_projectile_properties.bullet_bounce = _bounce_type;
		_projectile_properties.penetrative_value = _projectile_original.penetrative_value + _penetrative_num;
		_projectile_properties.bullet_spread = _projectile_original.bullet_spread+((_projectile_original.bullet_spread/2)*_num_bullet_spread);
        //show_debug_message("fire_rate num: " + string(_fire_rate_num));
    }

    global.mecha_guns.primary_gun = _gun;
    return _projectile_properties;
}


function find_gun_module(_inventory){
    for (var i = 0; i < array_length(_inventory); i++) {
        var item_id = _inventory[i];
        if ((item_id != -1)&&(item_id != 0)) { // checks if the slot is not empty
			//show_debug_message("Item id:" + string(item_id));
            var item_info = global.items[item_id]; // get item information from the array
            if (item_info.type == "Gun_Module") {
				//show_debug_message("Gun_Module found: " + string(item_info.num_));
                return item_info.num_;
            }
        }
    }
    return -1; // Return -1 if no gun module is found
}

function find_upgrade_module(_inventory, _slot){
	var item_id = _inventory[_slot];
    if ((item_id != -1)&&(item_id != 0)) { // checks if the slot is not empty
		var item_info = global.items[item_id]; // get item information from the array
		//show_debug_message("Module item_info:" + string(item_id));
		if (item_info.type == "Upgrade_Module") {
			//show_debug_message("Module name:" + string(item_info.name));
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
        //show_debug_message("Gun type properties not found: " + _gun_type);
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
	_new_projectile.bounce = _projectile_properties.bullet_bounce;
	_new_projectile.penetrative_value = _projectile_properties.penetrative_value;
	_new_projectile.spread = _projectile_properties.bullet_spread;
	_new_projectile.sprite_index = _projectile_properties.projectile_spr;
	_new_projectile.lifespan = _projectile_properties.bullet_lifespan;
	_new_projectile.lifespan_rnd = _projectile_properties.bullet_lifespan_rng;
	_new_projectile.damage = _projectile_properties.bullet_damage;
	switch (_cooldown) {
	    case "gun_one_cooldown":
	        global.gun_one_cooldown = _projectile_properties.fire_rate;
	        break;
		case "gun_two_cooldown":
	        global.gun_two_cooldown = _projectile_properties.fire_rate;
	        break;
	}
	_new_projectile.initialize_projectile(_projectile_properties.projectile_type, _direction, _add_xspeed, _add_yspeed);
	_new_projectile.set_projectile(_projectile_properties.bullet_speed, _direction, _add_xspeed, _add_yspeed);
	
	
}