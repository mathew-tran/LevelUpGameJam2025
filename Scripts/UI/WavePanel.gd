extends Panel

func _ready() -> void:
	Finder.GetGame().OnRoundUpdate.connect(OnRoundUpdate)
	OnRoundUpdate(0, false)
func OnRoundUpdate(number, bIsBoss):
	if bIsBoss:
		$Label.text = "BOSS WAVE"
	else:
		$Label.text = "ROUND " + str(number)
	visible = true
	$AnimationPlayer.play("anim")
	await $AnimationPlayer.animation_finished
	visible = false
