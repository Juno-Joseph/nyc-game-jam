extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().root.content_scale_factor = 1.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	Global.MAIN.set_mode("res://Scenes/Levels/Title and Credits/Title Scence.tscn")
