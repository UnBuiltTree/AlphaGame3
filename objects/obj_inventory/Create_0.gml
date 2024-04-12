slot_size = sprite_get_width(spr_inv_slot);

row_length = 6;
inventory = array_create(INVENTORY_SLOTS, -1);
randomize();
inventory[0] = 0;
inventory[1] = 1;
inventory[2] = 1;
inventory[3] = 2;