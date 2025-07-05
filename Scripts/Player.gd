extends Node2D

var Speed = 100
@export var bIsHead = true

func _process(delta: float) -> void:
	if bIsHead:
		if global_position.distance_to(get_global_mouse_position()) > 50:
			var dir = (get_global_mouse_position() - global_position).normalized()
			global_position += dir * Speed * delta
