extends Spatial

var speed = 25

onready var target = get_parent().get_node("Head/Camera/GunTargetPos")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#global_transform.origin = global_transform.origin.linear_interpolate(target.global_transform.origin, speed*delta)
	#rotation_degrees = target.rotation_degrees
	global_transform = global_transform.interpolate_with(target.global_transform, speed*delta)
