extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@onready var animated_sprite = $AnimationPlayer
@onready var Sprite = $Sprite2D


func _ready() -> void:
	
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		animated_sprite.play("jump")
		velocity.y = JUMP_VELOCITY
		
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("idle")

	move_and_slide()
	
	
	if Input.is_action_pressed("ui_right"):
		animated_sprite.play("run")
		Sprite.flip_h = false
	
		
	if Input.is_action_pressed("ui_left"):
		animated_sprite.play("run")
		Sprite.flip_h = true
	
	
	
	
