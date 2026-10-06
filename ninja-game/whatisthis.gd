extends Node2D

@onready var home_button: Button = $Button

func _ready() -> void:
	home_button.pressed.connect(_open_home)

func _open_home() -> void:
	get_tree().change_scene_to_file("res://home.tscn")
