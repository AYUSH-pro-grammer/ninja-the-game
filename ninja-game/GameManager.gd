extends Node

var highest_unlocked_level: int = 0

func complete_level(level_number: int) -> void:
	if level_number + 1 > highest_unlocked_level:
		highest_unlocked_level = level_number + 1

func is_level_unlocked(level_number: int) -> bool:
	return level_number <= highest_unlocked_level
