extends Node2D

func _enter_tree() -> void:
	visible = false

func GetRandomSpawnPoint():
	return get_children().pick_random().global_position
