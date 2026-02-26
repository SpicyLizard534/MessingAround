x = room_width / 2;
y = room_height / 2;
image_xscale = 2;
image_yscale = .5;
hovering = false;
grow = 0;
FontPixel = font_add_sprite_ext(Spr_Text, "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", true, 2);
draw_set_font(FontPixel);
global.score = 0;