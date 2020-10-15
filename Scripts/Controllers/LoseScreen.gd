extends Control

func _process(delta):
	if Game.over:
		$Sceen.show()

func _on_Button_pressed():
	get_parent().restart()
	hide()
