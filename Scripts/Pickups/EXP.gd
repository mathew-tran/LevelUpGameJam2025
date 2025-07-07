extends Area2D

class_name EXPPickup

@export var Amount = 5
var bMoveTowardsPlayer  = false

func _enter_tree() -> void:
	scale = Vector2.ZERO
	
func _ready() -> void:	

	if Amount > 1000:
		$Sprite2D.texture = load("res://Art/Pickups/EXP3.png")
	elif Amount > 500:
		$Sprite2D.texture = load("res://Art/Pickups/EXP2.png")
	elif Amount >= 100:
		$Sprite2D.texture = load("res://Art/Pickups/EXP1.png")
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, .2)
	_on_poll_timer_timeout()
func IsFollowing():
	return bMoveTowardsPlayer
	
func SetFollowing():
	bMoveTowardsPlayer = true
	
func Pickup():
	Finder.GetGame().AddEXP(Amount)
	Jukebox.PlayPickupSFX()
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is BaseCharacter:
		Pickup()
		
		
func _process(delta: float) -> void:
	if bMoveTowardsPlayer:
		var dir = (Finder.GetPlayer().LastKnownPosition - global_position).normalized()
		global_position += dir * 500 * delta


func _on_timer_timeout() -> void:
	queue_free()


func _on_poll_timer_timeout() -> void:
	modulate.a = ($Timer.time_left / $Timer.wait_time)
