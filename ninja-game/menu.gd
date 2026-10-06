extends Node2D

@export var level0: PackedScene
@export var level1: PackedScene
@export var level2: PackedScene

@onready var button0: Button = $ButtonL0
@onready var button1: Button = $ButtonL1
@onready var button2: Button = $ButtonL2
@onready var home_button: Button = $home

@onready var status_b: Label = $statusB
@onready var status_c: Label = $statusC


func _ready() -> void:
	button0.pressed.connect(_open_level_0)
	button1.pressed.connect(_open_level_1)
	button2.pressed.connect(_open_level_2)
	home_button.pressed.connect(_open_home)

	_update_level_buttons()


func _update_level_buttons() -> void:
	button0.disabled = false

	button1.disabled = not GameManager.is_level_unlocked(1)
	button2.disabled = not GameManager.is_level_unlocked(2)

	if button1.disabled:
		status_b.text = "LOCKED"
	else:
		status_b.text = "UNLOCKED"

	if button2.disabled:
		status_c.text = "LOCKED"
	else:
		status_c.text = "UNLOCKED"


func _open_level_0() -> void:
	get_tree().change_scene_to_packed(level0)


func _open_level_1() -> void:
	get_tree().change_scene_to_packed(level1)


func _open_level_2() -> void:
	get_tree().change_scene_to_packed(level2)


func _open_home() -> void:
	get_tree().change_scene_to_file("res://home.tscn")
