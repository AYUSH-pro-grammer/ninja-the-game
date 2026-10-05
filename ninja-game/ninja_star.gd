extends Area2D

@export var speed: float = 1000.0

var direction: float = 1.0
var is_broken: bool = false

@onready var sprite: Sprite2D = $Sprite2D



func _ready() -> void:
	body_entered.connect(_on_body_entered)


	collision_mask = 0
	collision_mask |= 2
	collision_mask |= 4 


func _physics_process(delta: float) -> void:
	if is_broken:
		return


	global_position.x += direction * speed * delta


	if direction < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false


func _on_body_entered(body: Node2D) -> void:
	if is_broken:
		return


	if body.is_in_group("player"):
		return


	if body.is_in_group("enemy"):
		print("NINJA STAR HIT ENEMY: ", body.name)

		if body.has_method("die"):
			body.die()


		break_star()
		return
		



	print("NINJA STAR HIT WALL: ", body.name)

	break_star()


func break_star() -> void:
	if is_broken:
		return

	is_broken = true


	visible = false


	monitoring = false


	queue_free()
