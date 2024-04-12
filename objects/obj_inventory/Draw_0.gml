var _x = camera_get_view_x(view_camera[0]) + 8
var _y = camera_get_view_y(view_camera[0]) + 8 + 32

/*
draw_sprite_stretched(
	spr_inv_box,
	0,
	_x,
	_y,
	12 + row_length*slot_size,
	12 + (((INVENTORY_SLOTS-1) div row_length)+1)*slot_size
);
*/

for (var i = 0; i < INVENTORY_SLOTS; i += 1) {
    var xx = _x + (i mod row_length)*(slot_size+2);
	var yy = _y + (i div row_length)*(slot_size+2);
	draw_sprite(spr_inv_slot, 0, xx, yy);
	if(inventory[i] != -1){
		draw_sprite(spr_item, inventory[i], xx+3, yy+3);
	}
}