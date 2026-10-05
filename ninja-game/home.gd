extends Node2D

@export var menu_scene: PackedScene
@onready var button: Button = $Button


func _ready() -> void:
	button.pressed.connect(_on_button_pressed)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(menu_scene)
