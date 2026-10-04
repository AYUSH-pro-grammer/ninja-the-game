extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var patrol_speed: float = 150.0
@export var chase_speed: float = 350.0
@export var dead_screen: PackedScene

var player: CharacterBody2D = null

var left_limit: float
var right_limit: float

var direction: int = 1
var is_dead := false


func _ready() -> void:
	left_limit = get_parent().get_node("LeftPoint").global_position.x
	right_limit = get_parent().get_node("RightPoint").global_position.x


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if player != null:
		if player.global_position.x < left_limit or player.global_position.x > right_limit:
			player = null

	if player != null:
		if player.global_position.x > global_position.x:
			direction = 1
			velocity.x = chase_speed
		elif player.global_position.x < global_position.x:
			direction = -1
			velocity.x = -chase_speed
		else:
			velocity.x = 0
	else:
		velocity.x = direction * patrol_speed

	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()

		if body is Node2D and body.is_in_group("player"):
			player_died(body)
			return

	global_position.x = clamp(global_position.x, left_limit, right_limit)

	if global_position.x >= right_limit:
		direction = -1
	elif global_position.x <= left_limit:
		direction = 1

	if velocity.x != 0:
		sprite.play("running")
		sprite.flip_h = velocity.x < 0
	else:
		sprite.play("default")


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.global_position.x >= left_limit and body.global_position.x <= right_limit:
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
	body.disappear()

	await sprite.animation_finished

	get_tree().change_scene_to_packed(dead_screen)
	
	
