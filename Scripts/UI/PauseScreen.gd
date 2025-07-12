extends Panel

func _input(event: InputEvent) -> void:
	if event.is_action_released("pause") and Finder.GetGame().IsGameFinished() == false:
		visible = !visible
		if visible:
			$CharacterShowingContainer.OnLevelUpMenuOpened()
			$TeamSizeUI.Update()
			get_tree().paused = true
			$StatsPanel.Update()
		else:
			Close()
			
func Close():
	visible = false
	
	if Finder.GetGame().IsInGame():
		get_tree().paused = false

func _on_resume_button_button_up() -> void:
	Close()

func _on_character_select_button_up() -> void:
	get_tree().change_scene_to_packed(load("res://Prefabs/UI/CharacterSelect/CharacterSelectScreen.tscn"))
