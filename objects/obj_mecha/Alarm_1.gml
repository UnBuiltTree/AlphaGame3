
switch (_frame) {
    case 0:
        _frame = 1;
        break;
	case 1:
        _frame = 2;
        break;
	case 2:
        _frame = 3;
        break;
	case 3:
        _frame = 0;
        break;
    default:
        _frame = 0;
        break;
}

alarm[1] = _frame_rate;
