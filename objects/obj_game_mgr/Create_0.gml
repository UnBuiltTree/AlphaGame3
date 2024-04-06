// --- Create Event

global.main_menu = false;

enum GAME_STATE
{
	PLAYING,
	PAUSED,
	ENDED,
}

window_set_cursor(cr_none);

spawn_player = function(){
	//creates a player within the room and sets their ID to 0 ~Weston
	var _player = instance_create_layer(room_width/2, room_height/2,"Instances", obj_player);
	_player.player_initialize();
	_player.player_local_id = 0;
	show_debug_message("Player Spawned: " + string(_player.player_local_id));
	global.player_alive = true;
	curr_game_state = GAME_STATE.PLAYING;
	var boost_bar = instance_create_layer(16, 8,"Hud", obj_health_bar);
	var boost_bar = instance_create_layer(16, 26,"Hud", obj_boost_bar);
}

spawn_player();