extends Control

signal pick_done(pick)

export(Texture) var speed_logo
export(Texture) var health_logo
export(Texture) var time_logo
export(Texture) var jump_logo
export(Texture) var regen_logo
onready var power_logos = [speed_logo,health_logo,time_logo,jump_logo,regen_logo]

var improvements_pool = ["Speed","Health","Time Manipulation","Jump","Health Regenaration"]
var stored_improvements = ["Speed","Health","Time Manipulation"]

var rng = RandomNumberGenerator.new()

var displaying = false

func _process(delta):
	if !displaying:
		return
	if Input.is_action_just_pressed("pick_1"):
		pick_improvement(stored_improvements[0])
	if Input.is_action_just_pressed("pick_2"):
		pick_improvement(stored_improvements[1])
	if Input.is_action_just_pressed("pick_3"):
		pick_improvement(stored_improvements[2])

func pick_improvement(improvement):
	emit_signal("pick_done",improvement)
	displaying = false
	hide()

func display_improvements():
	show()
	displaying = true
	var logos = []
	for i in range (0,3):
		while true:
			var num = rng.randi_range(0,improvements_pool.size()-1)
			var improvement = improvements_pool[num] 
			if !stored_improvements.has(improvement):
				stored_improvements[i] = improvement
				logos.append(num)
				break
	$Control/Choises/Option1/Label.text = stored_improvements[0]
	$Control/Choises/Option1/Logo.texture = power_logos[logos[0]]
	$Control/Choises/Option2/Label.text = stored_improvements[1]
	$Control/Choises/Option2/Logo.texture = power_logos[logos[1]]
	$Control/Choises/Option3/Label.text = stored_improvements[2]
	$Control/Choises/Option3/Logo.texture = power_logos[logos[2]]

func _on_Option1_pressed():
	pick_improvement(stored_improvements[0])

func _on_Option2_pressed():
	pick_improvement(stored_improvements[1])

func _on_Option3_pressed():
	pick_improvement(stored_improvements[2])

func _on_Director_display_round_done():
	display_improvements()

func _on_TimeSpawner_time_taken():
	display_improvements()
