extends Area


func _ready():
	$time_item/AnimationPlayer.play("Rotate")


func _on_Time_body_entered(body):
	if body.is_in_group("Player"):
		body.add_time(30)
		get_parent().time_taken()
		queue_free()
