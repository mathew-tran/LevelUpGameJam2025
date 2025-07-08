extends Panel

func _ready() -> void:
	Finder.GetGame().OnPowerupGained.connect(OnPowerupGained)
	
func OnPowerupGained(department, text):
	$HBoxContainer/TextureRect.self_modulate = CharacterData.GetDepartmentColor(department)
	$HBoxContainer/Label.text = text
	visible = true
	$AnimationPlayer.play("anim")
	await $AnimationPlayer.animation_finished
	visible = false
