slot_size = sprite_get_width(spr_inv_slot);

row_length = 8;
inventory = array_create(INVENTORY_SLOTS, -1);
randomize();
inventory[0] = irandom_range(1, 4);
inventory[1] = irandom_range(6, 13);
inventory[2] = irandom_range(6, 13);
inventory[3] = irandom_range(6, 13);


