extends Spatial

var speed = 150

var damage = 15

var life_time = 4
var timer = 0

var hit_something = false

func _ready():
	$Area.connect("body_entered", self, "collided")
	$Area.connect("area_entered", self, "hit")

func _physics_process(delta):
	var forward_dir = -global_transform.basis.z.normalized()
	global_translate(forward_dir * speed * delta)

	timer += delta
	if timer >= life_time:
		print("too long")
		queue_free()

func hit(area):
	if area.is_in_group("enemy"):
		area.get_parent().queue_free()
		queue_free()

func collided(body):
	if body.is_in_group("invisible_wall") or body.is_in_group("Player"):
		return
	if hit_something == true:
		return
	
	if body.is_in_group("enemy"):
		body.queue_free()
		hit_something = true
		print("hit ground")
		queue_free()
		return
	var scene_root = get_parent()
	if body.is_in_group("grow_area"):
		queue_free()
		
	if body.is_in_group("plant"):
		body.get_parent().remove(true)
		queue_free()
