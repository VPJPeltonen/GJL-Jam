extends Spatial

signal spawn_enemies(amount)
signal display_round_done

var update_frequency = 1
var state = "normal"
var current_round = 1

func _ready():
	$Timer.start(update_frequency)

func _on_Timer_timeout():
	if Game.running:
		var enemies = get_tree().get_nodes_in_group("enemy")
		if enemies.size() == 0 and state == "normal":
			print("no enemies")
			emit_signal("display_round_done")
			state = "waiting"
		elif enemies.size() >= 1 and state == "waiting":
			state = "normal"
	$Timer.start(update_frequency)

func _on_RoundPassScreen_pick_done(pick):
	emit_signal("spawn_enemies",6+current_round*4)
	current_round += 1
