extends Area2D

class_name MagnetPickup


	
func _ready() -> void:	
	_on_poll_timer_timeout()

	
func Pickup():
	Jukebox.PlayPickupSFX()
	for pickup in Finder.GetPickupGroup().get_children():
		if pickup is EXPPickup:
			pickup.SetFollowing()
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is BaseCharacter:
		Pickup()
		

func _on_timer_timeout() -> void:
	queue_free()


func _on_poll_timer_timeout() -> void:
	modulate.a = ($Timer.time_left / $Timer.wait_time)
