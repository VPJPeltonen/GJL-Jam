extends Position3D

export(Resource) var heal_pack

var has_pack = false
var ready_to_spawn = true

func _process(delta):
	if !has_pack and ready_to_spawn:
		spawn_pack()
	
func spawn_pack():
	var pack = heal_pack.instance()
	has_pack = true
	add_child(pack)
	pack.global_transform.origin = global_transform.origin

func pack_taken():
	ready_to_spawn = false
	has_pack = false
	$Timer.start()

func _on_Timer_timeout():
	ready_to_spawn = true
