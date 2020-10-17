extends Spatial

export(Resource) var test_map

func restart():
	var children = get_children()
	for child in children:
		child.queue_free()
	var map = test_map.instance()
	add_child(map)
	map.global_transform = global_transform
	Game.over = false
	
