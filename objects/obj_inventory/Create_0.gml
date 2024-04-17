slot_size = sprite_get_width(spr_inv_slot);

row_length = 8;
inventory = array_create(INVENTORY_SLOTS, -1);
randomize();
inventory[0] = irandom_range(1, 4);
inventory[1] = irandom_range(6, 9);
inventory[2] = irandom_range(6, 9);
inventory[3] = irandom_range(6, 9);
inventory[4] = irandom_range(6, 9);
inventory[5] = irandom_range(6, 9);
inventory[6] = irandom_range(6, 9);
inventory[7] = irandom_range(6, 9);


