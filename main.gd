extends Node

var mode

func _ready():
	mode = $mode
	set_mode("res://Scenes/Levels/Level_1/Level_1.tscn")

func set_mode(path):
	remove_child(mode)
	mode = load(path).instantiate()
	add_child(mode)
	move_child(mode, 1)
