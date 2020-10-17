extends MeshInstance

var timer = 1
var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var forward_dir = -global_transform.basis.z.normalized()
	translation += forward_dir * speed * delta
	timer += delta
	if timer >= 1:
		queue_free()
