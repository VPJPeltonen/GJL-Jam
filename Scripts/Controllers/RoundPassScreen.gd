extends VBoxContainer

signal pick_done(pick)

var stored_improvements = ["Speed","Health","Time Manipulation"]

func pick_improvement(improvement):
	emit_signal("pick_done",improvement)
	Mouse.capture_mouse()
	hide()

func display_improvements():
	show()
	$Choises/Option1/Label.text = stored_improvements[0]
	$Choises/Option2/Label.text = stored_improvements[1]
	$Choises/Option3/Label.text = stored_improvements[2]

func _on_Option1_pressed():
	pick_improvement(stored_improvements[0])

func _on_Option2_pressed():
	pick_improvement(stored_improvements[1])

func _on_Option3_pressed():
	pick_improvement(stored_improvements[2])

func _on_Director_display_round_done():
	display_improvements()
	Mouse.free_mouse(false)
