extends Area

func _ready():
	$Spatial/AnimationPlayer.play("Shot_hover")

func _on_Shots_body_entered(body):
	if body.is_in_group("Player"):
		body.shots += 4
		body.get_node("Pickup").play()
		get_parent().weapon_taken()
		queue_free()
