extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func damage():
	$Damage.show()
	$Damage/Timer.start()

func update_meters(time,bullet_time,health):
	$Time/Bar.value = time
	var mod = time/100
	#if time < 25:
		#$Time/Bar.tint_progress = Color(1,0,0,1)
	#else:
	$Time/Bar.tint_progress = Color(1,mod,mod,1)
	$Health/Row/Time.value = bullet_time
	$Health/Row/Health.value = health
	var time_left = time/2
	var minutes = time_left / 60.0
	var seconds = int(time_left) % 60
	var milliseconds = (time_left - int(time_left))*1000 
	var str_elapsed = "%02d : %02d : %03d" % [minutes, seconds, milliseconds]
	#return str_elapsed
	$TimeLeft.text = str_elapsed

func update_time_meter_max(new_max):
	$Time/Bar.max_value = new_max

func update_health_meter_max(new_max):
	$Health/Row/Health.max_value = new_max
	
func update_ammo(shotgun,rockets):
	$Shots/Rocket_Shots.text = str(rockets)
	$Shots/Shotgun_Shots.text = str(shotgun)

func _on_Timer_timeout():
	$Damage.hide()
