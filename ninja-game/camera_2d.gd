extends Camera2D

@export var player: CharacterBody2D
@export var fixed_y: float = 0.0
@export var offset_x: float = -100.0

func _process(_delta):
	global_position.x = player.global_position.x + offset_x
	global_position.y = fixed_y
