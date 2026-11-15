extends Control

@onready var card: TextureRect = $Card
@onready var status_label: Label = $StatusLabel

var is_dragging: bool = false
var drag_offset: float = 0.0
var swipe_start_time: int = 0

var start_x: float
var end_x: float
var min_time_msec: int = 400 #Swipes under 400ms fail
var max_time_msec: int = 800 #Swipes under 800ms fail

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Save the starting position and set the required travel distance
	start_x = card.global_position.x
	end_x = start_x + 500.0
	
	# Connect the GUI input signal
	card.gui_input.connect(_on_card_gui_input)
	status_label.text = "Please insert card"


func _on_card_gui_input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Grab card
			is_dragging = true
			# Calc diff between mouse and card origin to prevent jitter
			drag_offset = get_global_mouse_position().x - card.global_position.x
			swipe_start_time = Time.get_ticks_msec()
			status_label.text = "Reading..."
		
		else:
			# Read card
			if is_dragging:
				is_dragging = false
				_evaluate_swipe()
		
	elif event is InputEventMouseMotion and is_dragging:
		# Move card
		var target_x = get_global_mouse_position().x - drag_offset
		# Clamp makes sure card cant leave left or right bounds
		card.global_position.x = clamp(target_x, start_x, end_x)

func _evaluate_swipe() -> void:
	# Calc time elapsed in milliseconds
	var swipe_duration = Time.get_ticks_msec() - swipe_start_time
	var distance_swiped = card.global_position.x - start_x
	var required_distance = (end_x - start_x) * 0.95 # Require 95% of the track
	
	# Check fail states first
	if distance_swiped < required_distance:
		status_label.text = "PLEASE SWIPE AGAIN"
	elif swipe_duration < min_time_msec:
		status_label.text = "TOO FAST SWIPE AGAIN"
	elif swipe_duration > max_time_msec:
		status_label.text = "TOO SLOW SWIPE AGAIN"
	else:
		# Good Swipe
		status_label.text = "PAID $2.75 \n BAL $0.00"
		card.gui_input.disconnect(_on_card_gui_input) # Lock the card
		
		await get_tree().create_timer(0.7).timeout
		
		get_tree().change_scene_to_file("res://Scenes/Levels/Level_3/Level_3.tscn")
		
	
	var tween = create_tween()
	tween.tween_property(card, "global_position:x", start_x, 0.2).set_trans(Tween.TRANS_SINE)
