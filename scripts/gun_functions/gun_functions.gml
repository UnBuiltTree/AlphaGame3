// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function obj_player_gun(){
	
}

function create_item_table(){
	global.items = [];

	global.items[1] = {
	    name: "Player_Submachine_gun",
		type: "Gun_Module",
	    info: "A rapid fire machine gun for sustained close quarters combat"
	};
	global.items[2] = {
	    name: "Player_Assault_gun",
		type: "Gun_Module",
	    info: "An auto fire gun for sustained mid-range combat"
	};
	global.items[3] = {
	    name: "Player_AntiMat_gun",
		type: "Gun_Module",
	    info: "A single fire gun, bolt slugger for long-range sniping"
	};
	global.items[4] = {
	    name: "Player_Plasma_gun",
		type: "Gun_Module",
	    info: "A rapid fire energy weapon, usefull for close-range crowd control"
	};

	// add more items and modules here other items

}

function build_gun(_inventory) {
	_gun = find_gun_module(_inventory);
	show_debug_message(string(_gun))
}

function find_gun_module(_inventory){
    for (var i = 0; i < array_length(_inventory); i++) {
        var item_id = _inventory[i];
        if ((item_id != -1)&&(item_id != 0)) { // checks if the slot is not empty
			show_debug_message("Item id:" + string(item_id));
            var item_info = global.items[item_id]; // get item information from the array
            if (item_info.type == "Gun_Module") {
                return item_info.name; // returns the name of the gun
            }
        }
    }
    return "No Gun Module found"; // Return default message if no gun module is found
}