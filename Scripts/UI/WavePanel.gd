extends Panel

func _ready() -> void:
	Finder.GetGame().OnRoundUpdate.connect(OnRoundUpdate)
	
func OnRoundUpdate(number, customText):
	if customText != "":
		$Label.text = customText
	else:
		$Label.text = "ROUND " + str(number)
	visible = true
	$AnimationPlayer.play("anim")
	await $AnimationPlayer.animation_finished
	visible = false
