extends Buff
	

func _on_poll_timer_timeout() -> void:
	CharRef.bDoubleDamage = true

func CleanBuff():
	CharRef.bDoubleDamage = false
	
