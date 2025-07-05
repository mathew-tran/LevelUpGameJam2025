extends Node2D

class_name BaseProjectile

var Direction = Vector2.RIGHT
var Speed = 50
var Damage = 3

func _process(delta: float) -> void:
	global_position += Direction * Speed
	


func _on_live_timer_timeout() -> void:
	queue_free()
