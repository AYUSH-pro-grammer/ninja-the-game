extends Area2D

const SPEED = 2000 
var direction = 0.1 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x += SPEED * direction * delta
	
