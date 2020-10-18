extends Spatial

signal time_taken

export(PackedScene) var TimeItem

onready var points = $Points.get_children()

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	spawn_time()

func spawn_time():
	var new_time = TimeItem.instance()
	var position = points[rng.randi_range(0,points.size()-1)].global_transform.origin
	add_child(new_time)
	new_time.global_transform.origin = position

func time_taken():
	emit_signal("time_taken")

func _on_RoundPassScreen_pick_done(pick):
	spawn_time()
