extends VBoxContainer

signal pick_done(pick)

var improvements_pool = ["Speed","Health","Time Manipulation","Jump","Health Regenaration"]
var stored_improvements = ["Speed","Health","Time Manipulation"]

var rng = RandomNumberGenerator.new()

func pick_improvement(improvement):
	emit_signal("pick_done",improvement)
	Mouse.capture_mouse()
	hide()

func display_improvements():
	show()
	for i in range (0,3):
		while true:
			var improvement = improvements_pool[rng.randi_range(0,improvements_pool.size()-1)] 
			if !stored_improvements.has(improvement):
				stored_improvements[i] = improvement
				break
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
