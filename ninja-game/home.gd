extends Node2D

@export var menu_scene: PackedScene

@onready var button: Button = $Button
@onready var button2: Button = $Button2
@onready var options_button: Button = $ButtonOptions

@onready var controls_panel: Control = $Control
@onready var close_button: Button = $Control/ButtonClose
@onready var change_button: Button = $Control/ButtonChange
@onready var view_button: Button = $Control/ButtonView
@onready var controls_label: Label = $Control/Label


func _ready() -> void:
	# Main button
	button.pressed.connect(_on_button_pressed)

	# WHAT IS THIS button
	button2.pressed.connect(_open_what_is_this)

	# Options button
	options_button.pressed.connect(_open_options)

	# Close options
	close_button.pressed.connect(_close_options)

	# Options buttons
	change_button.pressed.connect(_change_controls)
	view_button.pressed.connect(_view_controls)

	# Hide options when Home starts
	controls_panel.hide()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(menu_scene)


func _open_what_is_this() -> void:
	get_tree().change_scene_to_file("res://whatisthis.tscn")


func _open_options() -> void:
	controls_panel.show()


func _close_options() -> void:
	controls_panel.hide()


func _view_controls() -> void:
	controls_label.text = """CONTROLS

←  →     MOVE

SPACE    JUMP
         DOUBLE JUMP

W        DASH

A        NINJA STAR"""


func _change_controls() -> void:
	controls_label.text = """CHANGE CONTROLS

CURRENT CONTROLS

←  →     MOVE
SPACE    JUMP
W        DASH
A        NINJA STAR

Control changing coming soon!"""
