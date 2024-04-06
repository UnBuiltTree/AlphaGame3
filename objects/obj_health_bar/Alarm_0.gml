/// @description Insert description here
// You can write your code in this editor

switch (_flash) {
    case 0:
        _flash_color = c_lime
		_flash = 1;
        break;
	case 1:
		_flash_color = c_yellow
		_flash = 0;
		break;
}

alarm[0] = 10;