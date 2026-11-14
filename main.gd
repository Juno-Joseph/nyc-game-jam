extends Node

var mode

func _ready():
	var scaling = 3
	get_window().set_size(Vector2(get_viewport().size.x*scaling, get_viewport().size.y*scaling))
	mode = $mode
	set_mode("res://Scenes/Levels/Level_1/Level_1.tscn")

func set_mode(path):
	remove_child(mode)
	mode = load(path).instantiate()
	add_child(mode)
	move_child(mode, 1)
