extends Spatial

var speed = 25

onready var target = get_parent().get_node("Head/Camera/GunTargetPos")

func _physics_process(delta):
	global_transform = global_transform.interpolate_with(target.global_transform, speed*delta)
