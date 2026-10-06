extends Area2D

@export var level_number: int = 0
@export var finish_scene: PackedScene

var completed := false

func _on_body_entered(body: Node2D) -> void:
	if completed:
		return

	if body.is_in_group("player"):
		completed = true

		GameManager.complete_level(level_number)

		get_tree().change_scene_to_packed(finish_scene)
