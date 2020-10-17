extends Spatial

onready var portal_top = $Position3D

func _on_Catcher_body_entered(body):
	if body.is_in_group("Player"):
		body.global_transform.origin = portal_top.global_transform.origin
		body.damage(20)
