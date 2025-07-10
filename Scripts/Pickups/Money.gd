extends Area2D

class_name MoneyPickup
@export var Amount = 1

func _ready() -> void:
	_on_poll_timer_timeout()
	scale = Vector2.ONE * lerp(1,4, clamp(Amount, 1, 20)/20)
	
func _on_body_entered(body: Node2D) -> void:
	Finder.GetGame().AddMoney(Amount)
	Jukebox.PlayPickupSFX()
	if Finder.GetGame().bGainHealthWhenMoneyPickedUp:
		for worker in Finder.GetWorkerGroup().get_children():
			worker.Heal(2)
			
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()


func _on_poll_timer_timeout() -> void:
	modulate.a = ($Timer.time_left / $Timer.wait_time)
