extends Node2D
 
 
const BULLET = preload("res://Scenes/bullet.tscn")
 
 
@onready var muzzle: Marker2D = $Marker2D
@onready var shoot_timer: Timer = $Timer

 
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
 
	#rotation_degrees = wrap(rotation_degrees, 0, 360)
	#if rotation_degrees > 90 and rotation_degrees < 270:
		#scale.y = -1
	#else:
		#scale.y = 1
 
	if Input.is_action_pressed("shoot") and shoot_timer.is_stopped():
		shoot()
		shoot_timer.start()
		
func shoot() -> void:
	var bullet_instance = BULLET.instantiate()
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.rotation = rotation
