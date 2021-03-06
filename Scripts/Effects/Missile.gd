extends KinematicBody

export(Resource) var explosion

var speed = 25

var damage = 15

var life_time = 8
var timer = 0

var hit_something = false
var shooter

func _physics_process(delta):
	var forward_dir = -global_transform.basis.z.normalized()
	var collission = move_and_collide(forward_dir * speed * delta)

	if collission != null:
		if collission.collider == shooter:
			return
		explode()
		if collission.collider.is_in_group("enemy"):
			collission.collider.damage(damage)
			hit_something = true
			print("hit enemu")
			queue_free()
			return
		if collission.collider.is_in_group("Player"):
			collission.collider.damage(damage)
			queue_free()
			return
		queue_free()
	timer += delta
	if timer >= life_time:
		print("too long")
		queue_free()

func explode():
	var blast_area = explosion.instance()
	get_parent().add_child(blast_area)
	blast_area.global_transform = global_transform

func hit(area):
	if area.is_in_group("enemy"):
		area.get_parent().queue_free()
		queue_free()

func collided(body):
	if body.is_in_group("invisible_wall"):
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
		queue_free()
		return
	print("weird")
