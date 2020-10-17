extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_meters(time,bullet_time,health):
	$Time/Bar.value = time
	$Health/Row/Time.value = bullet_time
	$Health/Row/Health.value = health

func update_time_meter_max(new_max):
	$Time/Bar.max_value = new_max

func update_ammo(shotgun,rockets):
	$Shots/Rocket_Shots.text = str(rockets)
	$Shots/Shotgun_Shots.text = str(shotgun)
