extends Area

func _ready():
	$AnimationPlayer.play("medHover")

func _on_MedPack_body_entered(body):
	if body.is_in_group("Player"):
		body.heal(20)
		get_parent().pack_taken()
		queue_free()
