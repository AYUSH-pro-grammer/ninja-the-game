extends Node2D

@onready var home_button: Button = $Button

func _ready() -> void:
	home_button.pressed.connect(_open_menu)

func _open_menu() -> void:
	print("HOME BUTTON PRESSED")
	get_tree().change_scene_to_file("res://menu.tscn")
