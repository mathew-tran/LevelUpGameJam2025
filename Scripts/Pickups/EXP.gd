extends Pickup


class_name EXPPickup

@export var Amount = 5


func _enter_tree() -> void:
	scale = Vector2.ZERO
	
func Setup():
	if Amount > 1000:
		$Sprite2D.texture = load("res://Art/Pickups/EXP3.png")
	elif Amount > 500:
		$Sprite2D.texture = load("res://Art/Pickups/EXP2.png")
	elif Amount >= 100:
		$Sprite2D.texture = load("res://Art/Pickups/EXP1.png")
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, .2)
	_on_poll_timer_timeout()

func DoPickupAction():
	Finder.GetGame().AddEXP(Amount)
	Jukebox.PlayPickupSFX()
