extends KinematicBody

var speed = 100

var damage = 15

var life_time = 4
var timer = 0

var hit_something = false

func _ready():
	pass
	#$Area.connect("body_entered", self, "collided")
	#$Area.connect("area_entered", self, "hit")

func _physics_process(delta):
	var forward_dir = -global_transform.basis.z.normalized()
	var collission = move_and_collide(forward_dir * speed * delta)
	
	if collission != null:
		if collission.collider.is_in_group("enemy"):
			collission.collider.damage(damage)
			hit_something = true
			print("hit enemu")
			queue_free()
			return
		if collission.collider.is_in_group("Player"):
			collission.collider.damage(damage)
			#hit_something = true
			#print("hit ground")
			queue_free()
			return
		queue_free()
	#global_translate(forward_dir * speed * delta)
	timer += delta
	if timer >= life_time:
		print("too long")
		queue_free()

func hit(area):
	if area.is_in_group("enemy"):
		area.get_parent().queue_free()
		queue_free()

func collided(body):
	if body.is_in_group("invisible_wall"):# or body.is_in_group("Player"):
		return
	if hit_something == true:
		return
	if body.is_in_group("enemy"): 
		body.damage(damage)
		hit_something = true
		print("hit enemu")
		queue_free()
		return
	if body.is_in_group("Player"):
		body.damage(damage)
		#hit_something = true
		#print("hit ground")
		queue_free()
		return
	print("weird")
