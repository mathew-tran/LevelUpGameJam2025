extends Buff
	

func SetupBuff():
	CharRef.StunChance += 100

func _on_poll_timer_timeout() -> void:
	return

func CleanBuff():
	CharRef.StunChance -= 100
	
