extends Area2D

class_name BaseProjectile

var Direction = Vector2.RIGHT
var Speed = 25
var Damage = 3
var Penetration = 0

func _ready():
	rotation = Direction.angle()
	
func _process(delta: float) -> void:
	global_position += Direction * Speed

func Hit():
	if Penetration <= 0:
		queue_free()
	else:
		Penetration -= 1
		
func _on_live_timer_timeout() -> void:
	queue_free()
