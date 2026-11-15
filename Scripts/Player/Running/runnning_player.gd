extends CharacterBody2D
class_name Level_1_Player

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var LOJUMP_VELOCITY = -100.0
@onready var animation_player = $AnimationPlayer
@onready var Sprite = $Sprite2D


func _ready() -> void:
	
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	var _jumped = false
	if Input.is_action_just_pressed("jump") and is_on_floor():
		_jumped = true
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("jump") and velocity.y < LOJUMP_VELOCITY:
		velocity.y = LOJUMP_VELOCITY
		
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
	if Input.is_action_pressed("right"):
		if(is_on_floor()): animation_player.play("run")
		Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		if(is_on_floor()): animation_player.play("run")
		Sprite.flip_h = true
	else:
		if(is_on_floor()): animation_player.play("idle")
	if !is_on_floor():
		if(_jumped):
			animation_player.play("jump")
		if(velocity.y > 0):
			animation_player.play("fall")



func _on_subway_goal_body_entered(body):
	if body is Level_1_Player:
		get_tree().change_scene_to_file("res://Scenes/Levels/Level_2/Level_2.tscn")
