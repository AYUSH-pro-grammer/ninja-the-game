extends Area2D

@export var speed: float = 1000.0

var direction: float = 1.0
var is_broken: bool = false

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)

	# Make sure the star doesn't detect the player.
	# We still keep this check in code as extra protection.
	collision_mask = 0
	collision_mask |= 2 # Enemy layer
	collision_mask |= 4 # World layer


func _physics_process(delta: float) -> void:
	if is_broken:
		return

	# Move visibly across the screen
	global_position.x += direction * speed * delta

	# Flip the arrow depending on direction
	if direction < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false


func _on_body_entered(body: Node2D) -> void:
	if is_broken:
		return

	# NEVER destroy the star because of the player
	if body.is_in_group("player"):
		return

	# Enemy hit
	if body.is_in_group("enemy"):
		print("NINJA STAR HIT ENEMY: ", body.name)

		if body.has_method("die"):
			body.die()

		break_star()
		return

	# Wall / platform / other world object
	print("NINJA STAR HIT WALL: ", body.name)

	break_star()


func break_star() -> void:
	if is_broken:
		return

	is_broken = true


	visible = false


	monitoring = false

	# Delete star
	queue_free()
