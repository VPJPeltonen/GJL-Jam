extends Spatial

onready var spawn_points = get_children()

export(Resource) var enemy1

var rng = RandomNumberGenerator.new()

func _on_Director_spawn_enemies(amount):
	print("spawning")
	for i in range(0,amount):
		var point = rng.randi_range(0,spawn_points.size()-1)
		var clone = enemy1.instance()
		var nav = get_parent()
		nav.add_child(clone)
		#print("shoot")
		clone.global_transform = spawn_points[point].global_transform
