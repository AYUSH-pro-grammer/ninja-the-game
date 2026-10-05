extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var patrol_speed: float = 150.0
@export var chase_speed: float = 350.0
@export var dead_screen: PackedScene

var player: CharacterBody2D = null

var left_limit: float
var right_limit: float

var direction: int = 1
var is_dead: bool = false


func _ready() -> void:
	left_limit = get_parent().get_node("LeftPoint").global_position.x
	right_limit = get_parent().get_node("RightPoint").global_position.x


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# =====================================
	# CHASE PLAYER
	# =====================================
	if player != null and is_instance_valid(player):

		if player.global_position.x > global_position.x:
			velocity.x = chase_speed
			sprite.flip_h = false

		elif player.global_position.x < global_position.x:
			velocity.x = -chase_speed
			sprite.flip_h = true

		else:
			velocity.x = 0.0

		sprite.play("running")

	# =====================================
	# PATROL
	# =====================================
	else:
		player = null

		velocity.x = direction * patrol_speed

		sprite.play("running")
		sprite.flip_h = velocity.x < 0

	# Move enemy
	move_and_slide()

	# =====================================
	# CHECK REAL PHYSICAL COLLISION
	# =====================================
	for i in get_slide_collision_count():

		var collision := get_slide_collision(i)
		var body := collision.get_collider()

		if body is Node2D and body.is_in_group("player"):
			player_died(body)
			return

	# =====================================
	# PATROL LIMITS
	# =====================================
	if player == null:

		if global_position.x >= right_limit:
			global_position.x = right_limit
			direction = -1

		elif global_position.x <= left_limit:
			global_position.x = left_limit
			direction = 1


# =====================================
# DETECTION AREA
# ONLY USED FOR CHASING
# =====================================

func _on_detection_area_body_entered(body: Node2D) -> void:

	if body.is_in_group("player"):
		print("PLAYER ENTERED DETECTION AREA")
		player = body


func _on_detection_area_body_exited(body: Node2D) -> void:

	if body == player:
		print("PLAYER LEFT DETECTION AREA")
		player = null


# =====================================
# ENEMY DIES
# =====================================

func die() -> void:

	if is_dead:
		return

	is_dead = true
	velocity = Vector2.ZERO

	set_physics_process(false)

	sprite.play("disappear")

	await sprite.animation_finished

	queue_free()


# =====================================
# PLAYER DIES
# =====================================

func player_died(body: Node2D) -> void:

	if is_dead:
		return
		
	
	is_dead = true
	velocity = Vector2.ZERO

	set_physics_process(false)

	sprite.play("disappear")

	# Stop player immediately
	if body.has_method("disappear"):
		body.disappear()

	await sprite.animation_finished

	get_tree().change_scene_to_packed(dead_screen)
