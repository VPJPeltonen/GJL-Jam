extends KinematicBody

export var speed = 5.0
var path = []
var state = "default"
var current_target
var current_node = 0

var model
var rng = RandomNumberGenerator.new()

onready var nav = get_parent()
onready var walk_point = [get_parent().get_node("Position3D"),get_parent().get_node("Position3D2"),get_parent().get_node("Position3D3"),get_parent().get_node("Position3D4")]
	
	
func _ready():
	rng.randomize()
	
func _process(delta):
	move()

func move():
	if current_node < path.size():
		var dir = (path[current_node] - global_transform.origin)
		if dir.length() < 1:
			current_node += 1
		else:
			move_and_slide(dir.normalized() * speed, Vector3.UP )	
	else:
		move_to(walk_point[rng.randi_range(0,3)].global_transform.origin)
		
func init(worker_model):
	model = worker_model
	move_to(walk_point[rng.randi_range(0,3)].global_transform.origin)

func move_to(target):
	path = nav.get_simple_path(global_transform.origin, target)
	current_node = 0
