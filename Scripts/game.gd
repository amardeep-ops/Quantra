extends Node2D

var enemy= preload("res://Scenes/enemy.tscn")
@onready var player: CharacterBody2D = $Player

func _ready() -> void:
	randomize()
	


func _on_enemy_timer_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	$Player/Path2D/PathFollow2D.progress = rng.randi_range(0,3664)
	var instance = enemy.instantiate()
	instance.player = $Player
	
	instance.global_position = $Player/Path2D/PathFollow2D/Marker2D.global_position
	add_child(instance)
	
