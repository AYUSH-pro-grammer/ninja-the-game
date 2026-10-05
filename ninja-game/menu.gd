extends Node2D

@export var level0: PackedScene
@export var level1: PackedScene
@export var level2: PackedScene
@export var level3: PackedScene
@export var level4: PackedScene
@export var level5: PackedScene
@export var level6: PackedScene
@export var level7: PackedScene
@export var level8: PackedScene
@export var level9: PackedScene

@onready var button0: Button = $ButtonL0
@onready var button1: Button = $ButtonL1
@onready var button2: Button = $ButtonL2
@onready var button3: Button = $ButtonL3
@onready var button4: Button = $ButtonL4
@onready var button5: Button = $ButtonL5
@onready var button6: Button = $ButtonL6
@onready var button7: Button = $ButtonL7
@onready var button8: Button = $ButtonL8
@onready var button9: Button = $ButtonL9


func _ready() -> void:

	button0.pressed.connect(_open_level_0)
	button1.pressed.connect(_open_level_1)
	button2.pressed.connect(_open_level_2)
	button3.pressed.connect(_open_level_3)
	button4.pressed.connect(_open_level_4)
	button5.pressed.connect(_open_level_5)
	button6.pressed.connect(_open_level_6)
	button7.pressed.connect(_open_level_7)
	button8.pressed.connect(_open_level_8)
	button9.pressed.connect(_open_level_9)

	_update_level_buttons()


func _update_level_buttons() -> void:

	button0.disabled = not GameManager.is_level_unlocked(0)
	button1.disabled = not GameManager.is_level_unlocked(1)
	button2.disabled = not GameManager.is_level_unlocked(2)
	button3.disabled = not GameManager.is_level_unlocked(3)
	button4.disabled = not GameManager.is_level_unlocked(4)
	button5.disabled = not GameManager.is_level_unlocked(5)
	button6.disabled = not GameManager.is_level_unlocked(6)
	button7.disabled = not GameManager.is_level_unlocked(7)
	button8.disabled = not GameManager.is_level_unlocked(8)
	button9.disabled = not GameManager.is_level_unlocked(9)


func _open_level_0() -> void:
	get_tree().change_scene_to_packed(level0)


func _open_level_1() -> void:
	get_tree().change_scene_to_packed(level1)


func _open_level_2() -> void:
	get_tree().change_scene_to_packed(level2)


func _open_level_3() -> void:
	get_tree().change_scene_to_packed(level3)


func _open_level_4() -> void:
	get_tree().change_scene_to_packed(level4)


func _open_level_5() -> void:
	get_tree().change_scene_to_packed(level5)


func _open_level_6() -> void:
	get_tree().change_scene_to_packed(level6)


func _open_level_7() -> void:
	get_tree().change_scene_to_packed(level7)
	

func _open_level_8() -> void:
	get_tree().change_scene_to_packed(level8)


func _open_level_9() -> void:
	get_tree().change_scene_to_packed(level9)
