extends Control

func _process(delta):
	if Game.over:
		$Sceen.show()

func _on_Button_pressed():
	var main = get_tree().get_nodes_in_group("main")[0]
	main.restart()
	hide()
