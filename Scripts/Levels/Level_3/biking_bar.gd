extends Control

@onready var progress_bar:ProgressBar = $ProgressBar
@onready var finished_label: Label = $ProgressBar/FinishedLabel

@export var current_value: float = 40.0
@export var decay_rate: float = 15 # How fast the bar drops per second
@export var fill_amount: float = 8.0 # How much the bar fills per press

@export var sweet_spot_min: float = 20.0
@export var sweet_spot_max: float = 80.0
var time_in_sweet_spot: float = 0.0
@export var required_win_time: float = 1.0 # Seconds needed to hold it into the sweet spot

var last_button: String = ""
var game_active: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_bar.max_value = 100.0
	progress_bar.value = current_value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if not game_active:
		return
	
	# Bar constatly decrasing if buttons not being pressed
	current_value -= decay_rate * delta
	current_value = clamp(current_value, 0.0, 100.0)
	progress_bar.value = current_value
	
	# Check if the currect value is within sweetspot
	if current_value >= sweet_spot_min and current_value <= sweet_spot_max:
		progress_bar.modulate = Color("0dff05ff")
		time_in_sweet_spot += delta
		
		if time_in_sweet_spot >= required_win_time:
			game_active = false
			finished_label.text = "Finished!"
			finished_label.show()
			await get_tree().create_timer(0.7).timeout
			Global.MAIN.set_mode("res://Scenes/Levels/Cutsences/Ending/Ending Cutsence.tscn")
	else:
		progress_bar.modulate = Color("ff0000ff") 
		#Lose progress if it falls out of the sweet spot
		time_in_sweet_spot = max(0.0, time_in_sweet_spot - delta)


func _input(event: InputEvent) -> void:
	if not game_active:
		return
	
	# Check for alternating presses
	if event.is_action_pressed("ui_left") and last_button != "left":
		_add_progress()
		last_button = "left"
	if event.is_action_pressed("ui_right") and last_button != "right":
		_add_progress()
		last_button = "right"

func _add_progress() -> void:
	# If pressed to fast it will shoot past the sweet spot max
	current_value += fill_amount
	current_value = clamp(current_value, 0.0, 100)
