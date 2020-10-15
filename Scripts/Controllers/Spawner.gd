extends Spatial

onready var spawn_points = get_children()

export(Resource) var enemy1
export(Resource) var drone

onready var basic_enemies = [enemy1,drone]

var rng = RandomNumberGenerator.new()

func _on_Director_spawn_enemies(amount):
	print("spawning")
	for i in range(0,amount):
		var point = rng.randi_range(0,spawn_points.size()-1)
		var clone = basic_enemies[rng.randi_range(0,basic_enemies.size()-1)].instance()#enemy1.instance()
		var nav = get_parent()
		nav.add_child(clone)
		#print("shoot")
		clone.global_transform = spawn_points[point].global_transform
