extends Buff
	

func _on_poll_timer_timeout() -> void:
	CharRef.GiveTempInvincibility(3)
