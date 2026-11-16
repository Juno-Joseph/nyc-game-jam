extends CharacterBody2D
class_name Level_1_Enemy

@onready var playernode : CharacterBody2D = get_parent().get_node("RunningPlayer")

@export var SPEED = 300.0
@export var gravity = 15
@export_range(1,-1) var dir : int = 1

func _ready() -> void:
	
	#Checks direction value and sets it to 1 automatically 
	if dir == 0:
		dir = 1
	$Sprite2D.flip_h = false if dir == 1 else true 

func _physics_process(delta: float) -> void:
	
	#Checks the rays and flips the sprite based on collision
	if dir == 1 and (!$rightray.is_colliding() or $rightwallray.is_colliding()):
		$Sprite2D.flip_h = true
		dir = -1
		_wait_dir_change(-1)
		
	if dir == -1 and (!$leftray.is_colliding() or $leftwallray.is_colliding()):
		$Sprite2D.flip_h = false
		dir = 1
		_wait_dir_change(1)
	
	velocity.x = lerp(velocity.x, dir*SPEED, 10 * delta)
	velocity.y += gravity
	move_and_slide()

func _wait_dir_change(desired_dir: int):
	#creates timer
	await get_tree().create_timer(0.5).timeout
	desired_dir = dir
	pass
	
