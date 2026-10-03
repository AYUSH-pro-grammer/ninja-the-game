extends CharacterBody2D
@onready var NinjaStar:Area2D = $"../ninjaStar"
@export var ninja_star_scene: PackedScene



const SPEED = 400.0
const JUMP_VELOCITY = -700.0

const DASH_SPEED = 3000
var facing_diection = 1
var is_dashing = false

var DASH_TIME  = 0.1
var dash_timer = 0

var DASH_TIME_LIMIT = 1 
var dashed_time = 0


var jump_level = 0


var NINJA_STAR_TIME_LIMIT = 1
var ninja_star_time = 0





func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 2

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_level < 1:
		jump_level += 1
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed('dash') and not  is_dashing and dashed_time <= 0:
		is_dashing=true 
		dash_timer = DASH_TIME
		dashed_time = DASH_TIME_LIMIT
	
	if dashed_time > 0:
		dashed_time -= delta
		
	if Input.is_action_just_pressed("shoot") and ninja_star_time <= 0:
		var star = ninja_star_scene.instantiate()
		star.global_position = global_position
		star.direction = facing_diection
		get_tree().current_scene.add_child(star)
		ninja_star_time = NINJA_STAR_TIME_LIMIT
		
	if ninja_star_time > 0:
		ninja_star_time -= delta
		
		
		

		

		
	if is_dashing:
		velocity.x = DASH_SPEED * facing_diection
		dash_timer -= delta  
		
		if dash_timer <= 0:
			is_dashing = false
		

		
		
	if is_on_floor():
		jump_level = 0
		
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	if not is_dashing:
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			facing_diection = direction 
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
