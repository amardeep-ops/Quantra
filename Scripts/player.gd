extends CharacterBody2D

# Movement parameters
@export var speed: float = 200.0
@export var fly_force: float = -300.0  # Negative Y is UP in 2D
@export var max_fly_speed: float = -500.0
@export var gravity_scale: float = 1.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var fire: AnimatedSprite2D = $fire

# Get default gravity from project settings
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# --- 1. FLYING MECHANIC ---
	if Input.is_action_pressed("fly"):  # Triggers continuously while held
		# Accelerate upward
		velocity.y += fly_force * delta
		# Cap maximum upward speed so the player doesn't shoot off-screen forever
		velocity.y = max(velocity.y, max_fly_speed)
		fire.visible = true
	else:
		# Apply normal gravity when not flying
		velocity.y += gravity * gravity_scale * delta
		fire.visible = false

	# --- 2. HORIZONTAL MOVEMENT ---
	var direction := Input.get_axis("ui_left", "ui_right")	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	# --- 3. MOUSE AIMING / DIRECTION ---
	var mouse_position: Vector2 = get_global_mouse_position()
	
	# --- 3. DIRECTION / FLIPPING LOGIC ---
	if direction < 0:
		# Moving Left (Pressing A / Left Arrow)
		animated_sprite_2d.flip_h = true
	elif direction > 0:
		# Moving Right (Pressing D / Right Arrow)
		animated_sprite_2d.flip_h = false
	else:
		# Idle: Face the mouse position
		var mouse_x := get_global_mouse_position().x
		if mouse_x < global_position.x:
			animated_sprite_2d.flip_h = true   # Look Left
		elif mouse_x > global_position.x:
			animated_sprite_2d.flip_h = false  # Look Right

	# Apply physics movement
	move_and_slide()
