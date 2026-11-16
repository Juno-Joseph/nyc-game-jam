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
	
	
	if path == "res://Scenes/Levels/Title and Credits/Credits.tscn":
		$AudioStreamPlayer.stream = load("res://Assets/cutscene.ogg")
		$AudioStreamPlayer.play()
	else: if $AudioStreamPlayer.stream != load("res://Assets/bgm.ogg"):
		$AudioStreamPlayer.stream = load("res://Assets/bgm.ogg")
		$AudioStreamPlayer.play()
	if $AudioStreamPlayer.playing and $AudioStreamPlayer.stream == load("res://Assets/bgm.ogg"):
		pass
		
	
