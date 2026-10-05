extends Control

@onready var next_button: Button = $ButtonNext
@onready var menu_button: Button = $ButtonMenu

func _ready() -> void:
	next_button.pressed.connect(_open_next_level)
	menu_button.pressed.connect(_open_menu)

	if GameManager.highest_unlocked_level >= 10:
		next_button.hide()


func _open_next_level() -> void:
	match GameManager.highest_unlocked_level:
		1:
			get_tree().change_scene_to_file("res://level2.tscn")
		2:
			get_tree().change_scene_to_file("res://level2.tscn")
		3:
			get_tree().change_scene_to_file("res://level2.tscn")
		4:
			get_tree().change_scene_to_file("res://level2.tscn")
		5:
			get_tree().change_scene_to_file("res://level2.tscn")
		6:
			get_tree().change_scene_to_file("res://level2.tscn")
		7:
			get_tree().change_scene_to_file("res://level2.tscn")
		8:
			get_tree().change_scene_to_file("res://level2.tscn")
		9:
			get_tree().change_scene_to_file("res://level2.tscn")


func _open_menu() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
