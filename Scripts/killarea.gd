extends Area2D

@onready var timer: Timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	print("Collided with: ", body.name, " | Groups: ", body.get_groups())
	if body.name == "Player":
		timer.start()
		print("You Died!")


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
