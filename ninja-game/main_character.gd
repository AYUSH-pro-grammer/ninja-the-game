extends CharacterBody2D

@export var ninja_star_scene: PackedScene
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var star_spawn_point: Marker2D = $StarSpawnPoint

const SPEED = 400.0
const JUMP_VELOCITY = -700.0

const DASH_SPEED = 3000
var facing_diection = 1
var is_dashing = false

var DASH_TIME = 0.2
var dash_timer = 0

var DASH_TIME_LIMIT = 1
var dashed_time = 0

var jump_level = 0

var NINJA_STAR_TIME_LIMIT = 1
var ninja_star_time = 0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * 2

	if Input.is_action_just_pressed("ui_accept") and jump_level < 1:
		jump_level += 1
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("dash") and not is_dashing and dashed_time <= 0:
		is_dashing = true
		dash_timer = DASH_TIME
		dashed_time = DASH_TIME_LIMIT

	if dashed_time > 0:
		dashed_time -= delta

	if Input.is_action_just_pressed("shoot") and ninja_star_time <= 0:
		var star = ninja_star_scene.instantiate()
		get_tree().current_scene.add_child(star)
		star.global_position.x = star_spawn_point.global_position.x
		star.global_position.y = star_spawn_point.global_position.y
		star.direction = facing_diection
		ninja_star_time = NINJA_STAR_TIME_LIMIT

	if ninja_star_time > 0:
		ninja_star_time -= delta

	if is_dashing:
		velocity.x = DASH_SPEED * facing_diection
		dash_timer -= delta

		if dash_timer <= 0:
			is_dashing = false

	if is_on_floor() and velocity.x == 0:
		sprite.play("default")
	elif is_on_floor() and (velocity.x > 0 or velocity.x < 0):
		sprite.play("running")
	elif jump_level == 0:
		sprite.play("jump")
	elif jump_level == 1:
		sprite.play("doubleJump")

	if is_on_floor():
		jump_level = 0

	if not is_dashing:
		var direction := Input.get_axis("ui_left", "ui_right")

		if direction:
			velocity.x = direction * SPEED
			facing_diection = direction
			sprite.flip_h = direction < 0
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func disappear() -> void:
	velocity = Vector2.ZERO
	set_physics_process(false)

	sprite.play("disappear")

	await sprite.animation_finished
