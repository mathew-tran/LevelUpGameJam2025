extends Area2D

class_name BaseProjectile

var Direction = Vector2.RIGHT
var Speed = 25
var Damage = 3

func _ready():
	rotation = Direction.angle()
	
func _process(delta: float) -> void:
	global_position += Direction * Speed

func _on_live_timer_timeout() -> void:
	queue_free()
