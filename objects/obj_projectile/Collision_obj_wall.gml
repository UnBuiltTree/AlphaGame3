/*
var left = other.x - other.sprite_width / 2;  // Wall's left edge
var right = other.x + other.sprite_width / 2; // Wall's right edge
var top = other.y - other.sprite_height / 2;  // Wall's top edge
var bottom = other.y + other.sprite_height / 2; // Wall's bottom edge

var px_center = x; // Assuming this is the center of the projectile
var py_center = y; // Assuming this is the center of the projectile

// Calculate distances to each wall side correctly
var dist_left = abs(px_center - left);    // Distance to the left wall
var dist_right = abs(px_center - right);  // Distance to the right wall
var dist_top = abs(py_center - top);      // Distance to the top wall
var dist_bottom = abs(py_center - bottom);// Distance to the bottom wall

// Find the minimum distance to determine the nearest side
var min_dist = min(dist_left, dist_right, dist_top, dist_bottom);

// Determine the normal vector based on the nearest side
var _normal_x = 0; 
var _normal_y = 0;

if (min_dist == dist_left) {
    _normal_x = -1; // Normal points left
    _normal_y = 0;
} else if (min_dist == dist_right) {
    _normal_x = -1; // Normal points right
    _normal_y = 0;
} else if (min_dist == dist_top) {
    _normal_x = 0; // Normal points up
    _normal_y = -1;
} else if (min_dist == dist_bottom) {
    _normal_x = 0; // Normal points down
    _normal_y = -1;
}

hit_level(_normal_x, _normal_y);*/