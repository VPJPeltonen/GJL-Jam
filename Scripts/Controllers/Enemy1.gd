extends KinematicBody

export(Resource) var bullet

export var speed = 5.0

var path = []
var state = "default"
var current_target
var current_node = 0

var health = 3

var spot_range = 25.0
var shoot_range = 100.0
var reloaded = true

var model
var rng = RandomNumberGenerator.new()

onready var nav = get_parent()
onready var walk_point = [get_parent().get_node("Position3D"),get_parent().get_node("Position3D2"),get_parent().get_node("Position3D3"),get_parent().get_node("Position3D4")]
onready var Player = get_tree().get_nodes_in_group("Player")[0]
onready var bullet_source = $BulletSource
onready var animation_tree = $AnimationPlayer/AnimationTree

func _ready():
	rng.randomize()
	
func _physics_process(delta):
	match state:
		"default":
			look_for_player()
			animation_tree.set("parameters/Running/blend_position",1)
			animation_tree.set("parameters/toggle SHOOTING/active",false)
			move()
		"shoot":
			shoot()
			var look_pos = Vector3(Player.global_transform.origin.x,global_transform.origin.y,Player.global_transform.origin.z)
			look_at(look_pos,Vector3.UP)
			animation_tree.set("parameters/Running/blend_position",0)
			animation_tree.set("parameters/toggle SHOOTING/active",true)
			stay_in_range()

func damage(damage):
	health -= damage
	animation_tree.set("parameters/toggle Hurt Animation/active",true)
	if health <= 0:
		state = "dead"
		#$EnemyArmiture001/Skeleton.physical_bones_start_simulation()
		queue_free()

func stay_in_range():
	var distance = global_transform.origin.distance_to(Player.global_transform.origin) 
	if distance > spot_range:
		move_to(Player.global_transform.origin)
		state = "default"
	else:
		var space_state = get_world().direct_space_state
		var result = space_state.intersect_ray(global_transform.origin, Player.global_transform.origin, [self])
		if !result.has("collider"):
			return
		if !result.collider.is_in_group("Player"):
			move_to(Player.global_transform.origin)
			state = "default"
			
func look_for_player():
	var distance = global_transform.origin.distance_to(Player.global_transform.origin) 
	if distance < spot_range:
		var space_state = get_world().direct_space_state
		var result = space_state.intersect_ray(global_transform.origin, Player.global_transform.origin, [self])
		if result.collider.is_in_group("Player"):
			state = "shoot"

func shoot():
	if !reloaded:
		return
	var clone = bullet.instance()
	var scene_root = get_parent()
	scene_root.add_child(clone)
	print("shoot")
	clone.global_transform = bullet_source.global_transform
	clone.damage = 10
	clone.speed = 100
	$ReloadTimer.start()
	reloaded = false


func move():
	if current_node < path.size():
		var look_pos = Vector3(path[current_node].x,global_transform.origin.y,path[current_node].z)
		look_at(look_pos,Vector3.UP)
		#look_at(path[current_node],Vector3.UP)
		var dir = (path[current_node] - global_transform.origin)
		if dir.length() < 3:
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

func _on_ReloadTimer_timeout():
	reloaded = true
