extends Spatial

export(Resource) var test_map

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func restart():
	$VPJTestScene.queue_free()
	var map = test_map.instance()
	add_child(map)
	map.global_transform = global_transform
	Game.over = false
	
