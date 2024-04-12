// --- global.varables goes here ~Weston_1

global.main_menu = true;
global.debug_mode = false;
global.cheat_mode = false;

global.hide_shadows = false;
global.show_walls = false;

global.player_alive = false;

// --- end global.varables ~Weston_1


global._base_width = 480;
global._base_height = 270;

create_item_table();

menu_initialize  = function(){
	room_set_width(rm_start_menu, global._base_width);
    room_set_height(rm_start_menu, global._base_height);

    var _display_width = display_get_width();
    var _display_height = display_get_height();

    var _scale_factor = min(_display_width / global._base_width, _display_height / global._base_height);
	show_debug_message(string(_scale_factor))

    var _new_width = round(global._base_width * _scale_factor);
    var _new_height = round(global._base_height * _scale_factor);

    window_set_size(_new_width, _new_height);
    window_center();
	
	window_set_cursor(cr_none);
}

create_buttons = function(){
	instance_create_layer(room_width/2, room_height/2, "Buttons", obj_btn_start);
}

menu_initialize();
create_buttons();