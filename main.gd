extends Node

var mode

func _ready():
	Global.MAIN = self
	mode = $mode
	set_mode("res://Scenes/Levels/Title and Credits/Title Scence.tscn")
	$AudioStreamPlayer.play()

func set_mode(path):
	remove_child(mode)
	mode = load(path).instantiate()
	add_child(mode)
	move_child(mode, 1)
