extends Area2D
@export var dead_screen: PackedScene



func _ready() -> void:
	pass 
func _process(delta: float) -> void:
	pass
	
func _on_body_entered(body: Node2D) -> void:

	if body.is_in_group("player"):
		get_tree().change_scene_to_packed(dead_screen)

	elif body.is_in_group("enemy"):
		body.die()
