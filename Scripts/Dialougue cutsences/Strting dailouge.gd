extends Control


#nodes
@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var button: Button = $Button

#vars
var Dialogue_array : Array = [
	"So this is the Big Apple huh?",
	"Oh, I feel like my eyes are gonna pop right out from excitement!",
	"I-i gotta take a picture right away to send back to mama and the others!"]
var dialog_index : int = 0:
	set(vaule):
		dialog_index = vaule
		
		label.visible_characters = -1



#code

func _ready() -> void:
	
	timer.timeout.connect(animate_label)
	label.text = ""
	
	
	

func animate_label() -> void:
	
	if dialog_index >= Dialogue_array.size():
		return
	
	label.text = Dialogue_array[dialog_index]
	label.visible_characters += 1
	
	if label.visible_ratio == 1:
		dialog_index += 1
	else:
		timer.start()
	
	
	


func _on_button_pressed() -> void:
	if dialog_index >= Dialogue_array.size():
		Global.MAIN.set_mode("res://Scenes/Levels/Level_1/Level_1.tscn")
		return
	
	if timer.is_stopped():
		animate_label()
	else:
		dialog_index += 1
		timer.stop()

		
