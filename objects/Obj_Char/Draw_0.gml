draw_self()
for(i = 0; i < ds_list_size(grapple_checkx); i += 1)
{
	draw_point(ds_list_find_value(grapple_checkx, i), ds_list_find_value(grapple_checky, i));
}