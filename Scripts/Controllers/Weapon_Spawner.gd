extends Position3D

export(Resource) var shotgun
export(Resource) var missile

onready var weapons = [shotgun,missile]

var rng = RandomNumberGenerator.new()

var has_weapon = false
var ready_to_spawn = true

func _ready():
	rng.randomize()

func _process(delta):
	if !has_weapon and ready_to_spawn:
		spawn_weapon()
	
func spawn_weapon():
	var weapon = weapons[rng.randi_range(0,weapons.size()-1)].instance()
	has_weapon = true
	add_child(weapon)
	weapon.global_transform.origin = global_transform.origin

func weapon_taken():
	ready_to_spawn = false
	has_weapon = false
	$Timer.start()

func _on_Timer_timeout():
	ready_to_spawn = true
