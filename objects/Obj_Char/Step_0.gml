var xchange = keyboard_check(ord("D")) - keyboard_check(ord("A"));		//inputs for actions
var jump = keyboard_check_pressed(vk_space);
var dash = keyboard_check(vk_shift);
var tether = mouse_check_button(mb_right)
xdist = (mouse_x - x)
ydist = (mouse_y - y)

if jump_buffer > 0		//if jump pressed to early so feels better
{
	var jump2 = true;
}
else
{
	jump2 = false;
}

if keyboard_check_pressed(ord("F"))		//fullscreen
{
	if fullscreen = false
	{
		fullscreen = true;
	}
	else
	{
		fullscreen = false;
	}
	window_set_fullscreen(fullscreen);
}

if xchange = 0				//horizontal movement control
{
	if x_velocity != 0
	{
		if x_velocity > 0
		{
			x_velocity -= mov_friction;
		}
		else
		{
			x_velocity += mov_friction;
		}
	}
}
else if abs(x_velocity + xchange) < abs(max_speed)
{
	if !place_meeting(x + x_velocity + (xchange * 2), y, Obj_Grnd)
	{
		x_velocity += xchange * 2;
	}
	else if !place_meeting(x + x_velocity + (xchange), y, Obj_Grnd)
	{
		x_velocity += xchange;
	}
}
else if abs(x_velocity) > abs(max_speed)
{
	if place_meeting(x, y + 10, Obj_Grnd) && (sign(xchange) = sign(x_velocity)) 
	{
		if x_velocity > 0
		{
			x_velocity -= mov_friction;
		}
		else
		{
			x_velocity += mov_friction;
		}
	}
	else if place_meeting(x, y + 10, Obj_Grnd) && xchange = 0
	{
		if x_velocity > 0
		{
			x_velocity -= mov_friction * 2;
		}
		else
		{
			x_velocity += mov_friction * 2;
		}
	}
	else if place_meeting(x, y + 10, Obj_Grnd) && (sign(xchange) != sign(x_velocity))
	{
		if x_velocity > 0
		{
			x_velocity -= mov_friction * 3;
		}
		else
		{
			x_velocity += mov_friction * 3;
		}
	}
}

if !place_meeting(x, y + 10, Obj_Grnd)		//gravity
{
	y_velocity += 2;
}

if place_meeting(x, y + 1, Obj_Grnd) && jumps != max_jumps		//jump reset
{
	jumps = max_jumps;
}

if (jump = true || jump2 = true) && (jumps > 0 || (place_meeting(x + 15, y, Obj_Grnd) || place_meeting(x - 15, y, Obj_Grnd)))		//jump control
{
	if place_meeting(x, y + 1, Obj_Grnd) || (!place_meeting(x, y + 1, Obj_Grnd) && (!place_meeting(x + 15, y, Obj_Grnd) && !place_meeting(x - 15, y, Obj_Grnd)))
	{
		y_velocity -= 30;
		jumps -= 1;
	}
	else if !place_meeting(x, y + 1, Obj_Grnd) && (place_meeting(x + 15, y, Obj_Grnd) || place_meeting(x - 15, y, Obj_Grnd))
	{
		if place_meeting(x + 15, y, Obj_Grnd)
		{
			x_velocity -= 20
			y_velocity -= 35
		}
		if place_meeting(x - 15, y, Obj_Grnd)
		{
			x_velocity += 20
			y_velocity -= 35
		}
	}
}
else if jump = true && jumps <= 0
{
	jump_buffer = 5;
}

if jump_buffer > 0
{
	jump_buffer -= 1;
}

if dash = 1 && dash_timer <= 0		//dash control
{
	if (hor_dir > 0 && !place_meeting(x + 1, y, Obj_Grnd)) || (hor_dir < 0 && !place_meeting(x - 1, y, Obj_Grnd))
	{
		x_velocity += dash_speed * hor_dir
		dash_timer = 30
	}
}
if dash_timer >= 0
{
	dash_timer -= 1
}

if abs(x_velocity) <= 64		//horizontal collision
{
	if place_meeting(x + x_velocity, y, Obj_Grnd)
	{
		while place_meeting(x + x_velocity, y, Obj_Grnd)
		{
			if x_velocity > 0
			{
				x_velocity -= 1
			}
			else if x_velocity < 0
			{
				x_velocity += 1
			}
			else if x_velocity = 0
			{
				break
			}
		}
	}
}	
else
{
	for(var i = 32; i < abs(x_velocity); i += 32)
	{
		if place_meeting(x + (i * sign(x_velocity)), y, Obj_Grnd)
			{
				if x_velocity > 0
				{
					x_velocity = i
					while place_meeting(x + x_velocity, y, Obj_Grnd)
					{
						x_velocity -= 1
					}
					break
				}
				else
				{
					x_velocity = -i
					while place_meeting(x + x_velocity, y, Obj_Grnd)
					{
						x_velocity += 1
					}
					break
				}
			}
	}
}
if abs(y_velocity) <= 64		//vertical collision
{
	if place_meeting(x, y + y_velocity, Obj_Grnd)
	{
		while place_meeting(x, y + y_velocity, Obj_Grnd)
		{
			if y_velocity > 0
			{
				y_velocity -= 1
			}
			else if y_velocity < 0
			{
				y_velocity += 1
			}
			else if y_velocity = 0
			{
				break
			}
		}
	}
}	
else
{
	for(var i = 32; i < abs(y_velocity); i += 32)
	{
		if place_meeting(x, y + (i * sign(y_velocity)), Obj_Grnd)
			{
				if y_velocity > 0
				{
					y_velocity = i
					while place_meeting(x, y + y_velocity, Obj_Grnd)
					{
						y_velocity -= 1
					}
					break
				}
				else
				{
					y_velocity = -i
					while place_meeting(x, y + y_velocity, Obj_Grnd)
					{
						y_velocity += 1
					}
					break
				}
			}
	}
}

if tether = true				//finish tether, currently just angle of tether is callibrated
{
	if tether_status = 0		//scans if meeting object
	{
		ds_list_clear(grapple_checkx)
		ds_list_clear(grapple_checky)
		tether_timer = 0;
		if xdist >= 0 && ydist >= 0
		{
			tether_angle = arctan(ydist / xdist)
		}
		if xdist <= 0 && ydist >= 0
		{
			tether_angle = arctan(ydist / xdist)
		}
		if xdist <= 0 && ydist <= 0
		{
			tether_angle = arctan(ydist / xdist)
		}
		if xdist >= 0 && ydist <= 0
		{
			tether_angle = arctan(ydist / xdist)
		}
		if tether_angle != 90 && tether_angle != 270
		{
			var grapple = tan(tether_angle)
		}
		var testx = x;
		var testy = y;
		if tether_angle = 90
		{
			while (testy - y) < 1000
			{
				testy += 1
				if !place_empty(x, testy)
				{
					grapple_loc[0] = round(testx);
					grapple_loc[1] = round(testy);
					tether_status = 2;
					tether_distance = sqrt(power((x - grapple_loc[0]), 2) + power((y - grapple_loc[1]), 2))
					break;
				}
			}
			if tether_status != 2
			{
				tether_status = 1;
			}
		}
		else if tether_angle = 270
		{
			while (testy - y) < 1000
			{
				testy -= 1
				if !place_empty(x, testy)
				{
					grapple_loc[0] = round(testx);
					grapple_loc[1] = round(testy);
					tether_status = 2;
					tether_distance = sqrt(power((x - grapple_loc[0]), 2) + power((y - grapple_loc[1]), 2))
					break;
				}
			}
			if tether_status != 2
			{
				tether_status = 1;
			}
		}
		else if abs(grapple) > 1
		{
			while sqrt(power((testx - x), 2) + power((testy - y), 2)) < 1000
			{
				testy += 1 * sign(ydist)
				testx += (1/abs(grapple)) * sign(xdist)
				ds_list_add(grapple_checkx, testx)
				ds_list_add(grapple_checky, testy)
				if !place_empty(testx, testy)
				{
					grapple_loc[0] = round(testx);
					grapple_loc[1] = round(testy);
					tether_status = 2;
					tether_distance = sqrt(power((x - grapple_loc[0]), 2) + power((y - grapple_loc[1]), 2))
					break;
				}
			}
			if tether_status != 2
			{
				tether_status = 1;
			}
		}
		else if abs(grapple) <= 1
		{
			while sqrt(power((testx - x), 2) + power((testy - y), 2)) < 1000
			{
				testy += abs(grapple) * sign(ydist)
				testx += 1 * sign(xdist)
				ds_list_add(grapple_checkx, testx)
				ds_list_add(grapple_checky, testy)
				if !place_empty(testx, testy)
				{
					grapple_loc[0] = round(testx);
					grapple_loc[1] = round(testy);
					tether_status = 2;
					tether_distance = sqrt(power((x - grapple_loc[0]), 2) + power((y - grapple_loc[1]), 2))
					break;
				}
			}
			if tether_status != 2
			{
				tether_status = 1;
			}
		}
	}
	if tether_status = 2
	{
		if place_meeting(x, y + 5, Obj_Grnd)		//tweak so if held pulls further or resets momentum to pull in exact distance
		{
			var vel_ratio = abs(x - grapple_loc[0]) + abs(y - grapple_loc[1]);
			var y_percent = (y - grapple_loc[1]) / vel_ratio;
			var x_percent = (grapple_loc[0] - x) / vel_ratio;
			if sign(y_percent) == -1
			{
				x_percent = sign(x_percent)
			}
			else
			{
				y_velocity -= round(y_percent * grapple_force);
			}
			if sign(x_velocity) == sign(x_percent) || x_velocity == 0
			{
				x_velocity += round(x_percent * grapple_force);
			}
			else 
			{
				x_velocity = round(x_percent * grapple_force);
			}
			tether_status = 5;
		}
	}
}
else
{
	tether_distance = 0;
	tether_status = 0;
}

if place_meeting(x, y, Obj_Grnd)		//prevents glitching into terrain and getting stuck
{
	for(var o = 0;  o < 70; o += 1)
	{
		if !place_meeting(x + o, y, Obj_Grnd)
		{
			x += o
			break
		}
		if !place_meeting(x - o, y, Obj_Grnd)
		{
			x -= o
			break
		}
		if !place_meeting(x, y + o, Obj_Grnd)
		{
			y += o
			break
		}
		if !place_meeting(x, y - o, Obj_Grnd)
		{
			y -= o
			break
		}
	}
}

y += y_velocity;		//applies movement values to move character
x += x_velocity;

global.spee = tether_status

if sign(xchange) != 0		//gets direction facing
{
	hor_dir = sign(xchange)
}

