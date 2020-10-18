extends Control

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	Mouse.free_mouse(false)


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_ControlsButton_pressed():
	$Buttons.hide()
	$Button_display.show()

func _on_StartButton_pressed():
	emit_signal("start_game")
	hide()
	Mouse.capture_mouse()


func _on_BackButton_pressed():
	$Button_display.hide()
	$Buttons.show()
