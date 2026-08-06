extends CharacterBody2D

const speed = 70
var hp = 3

var player: CharacterBody2D
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	if velocity.x < 0:
		animated_sprite_2d.flip_h = true
	elif velocity.x > 0:
		animated_sprite_2d.flip_h = false
	move_and_slide()
	
	if hp<=0:
		queue_free()
	
func makepath() -> void:
	nav_agent.target_position = player.global_position


func _on_timer_timeout() -> void:
	makepath()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy_damager"):
		hp-=1
		area.get_parent().queue_free()
	
