extends KinematicBody

export var speed = 15
export var acceleration = 5
export var gravity = 0.9
export var jump_power = 60
export var mouse_sens = 0.3

export(Resource) var bullet

var velocity = Vector3()
var camera_x_rotation = 0

var inventory = []

var frozen = false
var on_ground = false
var in_wall_range = false
var wall_in_range
var reloaded = true
var move_state = "stand"

var current_time = 100
var max_time = 100
var bullet_time_toggled = false

onready var UI = get_parent().get_node("UI")
onready var bullet_source = get_node("Head/Camera/Position3D")
onready var sun = get_parent().get_node("Enviroment/Lighting/Sun")
onready var world = get_parent().get_node("Enviroment/Lighting/WorldEnvironment")
onready var raycasts = [$RayCast,$RayCast2,$RayCast3,$RayCast4]

func _input(event):
	if frozen:
		return
		
	if event is InputEventMouseMotion and Mouse.mouse_captured:
		#sideways rotation
		$Head.rotate_y(deg2rad(-event.relative.x * mouse_sens))
		
		#up down rotation
		var x_delta = event.relative.y * mouse_sens
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90: 
			$Head/Camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

func _process(delta):
	UI.update_time_meter(current_time)
	sun.light_energy = (current_time/max_time)-0.2
	world.environment.background_sky.sky_energy = (current_time/max_time)-0.2
	world.environment.background_sky.sun_energy = (current_time/max_time)-0.2
	if bullet_time_toggled:
		current_time -= 100*delta
	elif current_time < 100:
		current_time += 5*delta
	if current_time <= 0:
		toggle_bullet_time(false)

func _physics_process(delta):
	move_state = "stand"
	if frozen:
		return
	var space_state = get_world().direct_space_state
	if Input.is_action_just_pressed("shoot") and reloaded:	
		shoot()
	if Input.is_action_pressed("toggle_bullet_time") and current_time > 0:
		toggle_bullet_time(true)
	else:
		toggle_bullet_time(false)
	movement(delta)

func damage(damage):
	current_time -= damage
	#if health <= 0:
		#queue_free()

func toggle_bullet_time(toggle):
	if !toggle:
		bullet_time_toggled = false
		Engine.set_time_scale(1)
		UI.get_node("Overlay").get_material().set_shader_param("aberration_amount",0)
	else:
		bullet_time_toggled = true
		Engine.set_time_scale(0.1)	
		UI.get_node("Overlay").get_material().set_shader_param("aberration_amount",2)

func movement(delta):
	var head_basis = $Head.get_global_transform().basis
	var direction = Vector3()
	var walking = false
	if Input.is_action_pressed("move_forward"):
		direction -= head_basis.z
		walking = true
		move_state = "moving"
	elif Input.is_action_pressed("move_backward"):
		direction += head_basis.z
		walking = true
		move_state = "moving"
	
	if Input.is_action_pressed("move_left"):
		direction -= head_basis.x
		walking = true
		move_state = "moving"
	elif Input.is_action_pressed("move_right"):
		direction += head_basis.x
		walking = true
		move_state = "moving"
	
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	if not on_ground:
		velocity.y -= gravity
	
	if Input.is_action_just_pressed("jump"):
		if on_ground:
			velocity.y += jump_power
		elif in_wall_range:
			wall_jump()
	velocity = move_and_slide(velocity, Vector3.UP)
	
func wall_jump():
	var dir = Vector3(0,0,0)
	for ray in raycasts:
		print("checking ray")
		if ray.is_colliding() and ray.get_collider() != null:
			var collider = ray.get_collider()
			print("hit something")
			if collider.is_in_group("wall"):
				dir = global_transform.origin - ray.get_collision_point()
				print("jumping")
	velocity.y += jump_power
	
	dir = Vector3(dir.x,0,dir.z)
	dir = dir.normalized()
	velocity += jump_power * dir * 1
	
func shoot():
	var clone = bullet.instance()
	var scene_root = get_parent()
	scene_root.add_child(clone)
	print("shoot")
	clone.global_transform = bullet_source.global_transform
	clone.damage = 1
	$ReloadTimer.start()
	reloaded = false

func _on_Feet_body_entered(body):
	if body.is_in_group("ground"):
		on_ground = true

func _on_Feet_body_exited(body):
	if body.is_in_group("ground"):
		on_ground = false
		
func _on_ReloadTimer_timeout():
	reloaded = true

func _on_Wall_Jump_Range_body_entered(body):
	if body.is_in_group("wall"):
		wall_in_range = body
		in_wall_range = true

func _on_Wall_Jump_Range_body_exited(body):
	if body.is_in_group("wall"):
		in_wall_range = false
