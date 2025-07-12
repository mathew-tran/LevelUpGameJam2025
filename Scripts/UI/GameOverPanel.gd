extends Panel

func _ready() -> void:
	Finder.GetGame().OnGameOver.connect(OnGameOver)
	
func OnGameOver():
	var wavesSurvived = Finder.GetSpawner().Round - 1
	$WavesText.text = "You have survived " + str(wavesSurvived) + " waves."
	visible = true
	Finder.GetGame().SetGameState(Game.GAME_STATE.FINISHED)
	
func _on_button_button_up() -> void:
	get_tree().reload_current_scene()
	


func _on_char_select_button_button_up() -> void:
	get_tree().change_scene_to_packed(load("res://Prefabs/UI/CharacterSelect/CharacterSelectScreen.tscn"))
