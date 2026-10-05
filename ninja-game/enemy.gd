extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var detection_area: Area2D = get_parent().get_node("DetectionArea")
@onready var detection_shape: CollisionShape2D = detection_area.get_node("CollisionShape2D")

@export var patrol_speed: float = 150.0
@export var chase_speed: float = 350.0
@export var dead_screen: PackedScene

var player: CharacterBody2D = null

var left_limit: float
var right_limit: float

var direction := 1
var is_dead := false


func _ready() -> void:
	var shape = detection_shape.shape

	if shape is RectangleShape2D:
		var size = shape.size
		var rect = Rect2(-size / 2.0, size)

		var p1 = detection_shape.global_transform * rect.position
		var p2 = detection_shape.global_transform * Vector2(rect.end.x, rect.position.y)
		var p3 = detection_shape.global_transform * Vector2(rect.position.x, rect.end.y)
		var p4 = detection_shape.global_transform * rect.end

		left_limit = min(p1.x, p2.x, p3.x, p4.x)
		right_limit = max(p1.x, p2.x, p3.x, p4.x)


func _physics_process(delta: float) -> void:

	if is_dead:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if player != null and not is_instance_valid(player):
		player = null

	if player != null:
		if player.global_position.x < left_limit or player.global_position.x > right_limit:
			player = null

	if player != null:

		if player.global_position.x > global_position.x:
			direction = 1
			velocity.x = chase_speed
			sprite.flip_h = false

		elif player.global_position.x < global_position.x:
			direction = -1
			velocity.x = -chase_speed
			sprite.flip_h = true

		else:
			velocity.x = 0

		sprite.play("running")

	else:

		velocity.x = direction * patrol_speed
		sprite.flip_h = direction < 0
		sprite.play("running")

	move_and_slide()

	global_position.x = clamp(
		global_position.x,
		left_limit,
		right_limit
	)

	if global_position.x >= right_limit:
		direction = -1

	elif global_position.x <= left_limit:
		direction = 1

	for i in get_slide_collision_count():

		var collision := get_slide_collision(i)
		var body := collision.get_collider()

		if body is Node2D and body.is_in_group("player"):
			player_died(body)
			return


func _on_detection_area_body_entered(body: Node2D) -> void:

	if body.is_in_group("player"):
		player = body


func _on_detection_area_body_exited(body: Node2D) -> void:

	if body == player:
		player = null


func die() -> void:

	if is_dead:
		return

	is_dead = true
	velocity = Vector2.ZERO

	set_physics_process(false)

	sprite.play("disappear")

	await sprite.animation_finished
	
	queue_free()

func player_died(body: Node2D) -> void:

	if is_dead:
		return

	is_dead = true
	velocity = Vector2.ZERO

	set_physics_process(false)

	sprite.play("disappear")

	if body.has_method("disappear"):
		body.disappear()

	await sprite.animation_finished

	get_tree().change_scene_to_packed(dead_screen)
