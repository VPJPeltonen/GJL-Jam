extends Spatial

export(Resource) var enemy1
export(Resource) var drone

var rng = RandomNumberGenerator.new()
var spawn_amount = 0

onready var spawn_points = $Points.get_children()
onready var drone_nav = get_parent().get_node("DroneNavigation")
onready var nav = get_parent().get_node("Navigation")

onready var basic_enemies = [enemy1,drone]
onready var navs = [nav,drone_nav]


func _on_Director_spawn_enemies(amount):
	spawn_amount += amount
	if $Timer.is_stopped():
		$Timer.start()
		spawn_amount -= 1

func _on_Timer_timeout():
	print("spawning")
	var point = rng.randi_range(0,spawn_points.size()-1)
	var spawnable = rng.randi_range(0,basic_enemies.size()-1)
	var clone = basic_enemies[spawnable].instance()
	navs[spawnable].add_child(clone)
	clone.global_transform = spawn_points[point].global_transform
	if spawn_amount > 0:
		$Timer.start()
		spawn_amount -= 1
