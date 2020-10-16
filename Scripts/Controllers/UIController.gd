extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_time_meter(time):
	$Time/Bar.value = time

func update_time_meter_max(new_max):
	$Time/Bar.max_value = new_max
