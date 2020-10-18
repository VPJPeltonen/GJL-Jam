extends Area

func _ready():
	$AnimationPlayer.play("Hover")

func _on_Rockets_body_entered(body):
	if body.is_in_group("Player"):
		body.rockets += 2
		body.get_node("Pickup").play()
		get_parent().weapon_taken()
		queue_free()
