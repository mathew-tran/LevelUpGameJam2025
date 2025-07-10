extends TextureRect

class_name Buff

var CharRef : BaseCharacter

func SetupBuff():
	pass
	
func ApplyBuff(char : BaseCharacter):
	CharRef = char
	$Timer.start()
	$AnimationPlayer.play("anim")
	SetupBuff()
		
func _on_timer_timeout() -> void:
	Cleanup()
	queue_free()

func Cleanup():
	CleanBuff()
	
func CleanBuff():
	pass
