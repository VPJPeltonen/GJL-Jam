extends Spatial

signal spawn_enemies(amount)

var update_frequency = 1

func _ready():
	$Timer.start(update_frequency)

func _on_Timer_timeout():
	if Game.running:
		var enemies = get_tree().get_nodes_in_group("enemy")
		if enemies.size() == 0:
			print("no enemies")
			emit_signal("spawn_enemies",4)
	$Timer.start(update_frequency)
