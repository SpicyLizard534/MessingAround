hovering = position_meeting(device_mouse_x(0), device_mouse_y(0), id);
if hovering = true
{
	grow = 1;
}
else
{
	grow = 0;
}
if grow = 1
{
	if image_xscale < 2.5
	{
		image_xscale = image_xscale + 0.1;
	}
	if image_yscale < .7
	{
		image_yscale = image_yscale + 0.05;
	}
}
else
{
	if image_xscale > 2
	{
		image_xscale = image_xscale - 0.1;
	}
	if image_yscale > .5
	{
		image_yscale = image_yscale - 0.05;
	}
}
if hovering = true && mouse_check_button_pressed(mb_left)
{
	global.score += 1;
}