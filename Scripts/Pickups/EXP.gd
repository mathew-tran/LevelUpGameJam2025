extends Area2D

class_name EXPPickup

@export var Amount = 5
var bMoveTowardsPlayer  = false

func _ready() -> void:
	var intensity = lerp(1, 10, clamp(Amount,0,100) / 100)
	print(str(intensity) + " intensity")
	$Sprite2D.modulate.r = intensity
	$Sprite2D.modulate.g = intensity
	$Sprite2D.modulate.b = intensity
func IsFollowing():
	return bMoveTowardsPlayer
	
func SetFollowing():
	bMoveTowardsPlayer = true
	
func Pickup():
	Finder.GetGame().AddEXP(Amount)
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is BaseCharacter:
		Pickup()
		
func _process(delta: float) -> void:
	if bMoveTowardsPlayer:
		var dir = (Finder.GetPlayer().LastKnownPosition - global_position).normalized()
		global_position += dir * 500 * delta
