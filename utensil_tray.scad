// Rounded, tapered utensil tray
// Units: millimetres

$fn = 64;

// Overall outside dimensions
bot_outer_length = 190;
top_outer_length = 220;
outer_width    = 76;
outer_height   = 80;

inner_radius = 5;
wall = 2;

// Derived values
outer_radius = inner_radius + wall;
bot_sphere_dist_x = bot_outer_length - 2*outer_radius;
top_sphere_dist_x = top_outer_length - 2*outer_radius;
bot_sphere_dist_y = outer_width - 2*outer_radius;
top_sphere_dist_y = bot_sphere_dist_y;



module sphere_at(p, r) {
    translate(p) sphere(r = r);
}

// Eight spheres: four at the bottom corners and four at the top corners.
// The hull gives the tray its rounded corners, rounded rim/base transitions,
// vertical long walls, and outward-sloping short walls.
module outer_shell() {
    hull() {
        // Bottom layer: 190 mm between the outside corner extents.
        sphere_at([-bot_sphere_dist_x/2, -bot_sphere_dist_y/2, outer_radius], outer_radius);
        sphere_at([-bot_sphere_dist_x/2, +bot_sphere_dist_y/2, outer_radius], outer_radius);
        sphere_at([+bot_sphere_dist_x/2, -bot_sphere_dist_y/2, outer_radius], outer_radius);
        sphere_at([+bot_sphere_dist_x/2, +bot_sphere_dist_y/2, outer_radius], outer_radius);

        // // Top layer: 220 mm between the outside corner extents.
        sphere_at([-top_sphere_dist_x/2, -top_sphere_dist_y/2, outer_height], outer_radius);
        sphere_at([-top_sphere_dist_x/2, +top_sphere_dist_y/2, outer_height], outer_radius);
        sphere_at([+top_sphere_dist_x/2, -top_sphere_dist_y/2, outer_height], outer_radius);
        sphere_at([+top_sphere_dist_x/2, +top_sphere_dist_y/2, outer_height], outer_radius);
    }
}

// A second 8-sphere hull forms the cavity.  The upper sphere centres are
// above the outer rim, ensuring that this shell is open rather than capped.
module inner_shell() {
    hull() {
        // Bottom layer: 190 mm between the outside corner extents.
        sphere_at([-bot_sphere_dist_x/2, -bot_sphere_dist_y/2, outer_radius], inner_radius);
        sphere_at([-bot_sphere_dist_x/2, +bot_sphere_dist_y/2, outer_radius], inner_radius);
        sphere_at([+bot_sphere_dist_x/2, -bot_sphere_dist_y/2, outer_radius], inner_radius);
        sphere_at([+bot_sphere_dist_x/2, +bot_sphere_dist_y/2, outer_radius], inner_radius);

        // // Top layer: 220 mm between the outside corner extents.
        sphere_at([-top_sphere_dist_x/2, -top_sphere_dist_y/2, outer_height], inner_radius);
        sphere_at([-top_sphere_dist_x/2, +top_sphere_dist_y/2, outer_height], inner_radius);
        sphere_at([+top_sphere_dist_x/2, -top_sphere_dist_y/2, outer_height], inner_radius);
        sphere_at([+top_sphere_dist_x/2, +top_sphere_dist_y/2, outer_height], inner_radius);
    }
}

difference() {
    outer_shell();
    inner_shell();
    translate([0, 0, outer_height*1.5]) {
        cube(size=[top_outer_length*2, outer_width*2, outer_height], center=true);
    }
    
}
