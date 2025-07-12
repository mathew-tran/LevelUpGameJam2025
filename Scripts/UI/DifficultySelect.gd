extends Control


func _ready() -> void:
	GameData.OnDifficultySet.connect(OnDifficultySet)
	_on_medium_button_button_up()
	
func OnDifficultySet(diff):
	$Label.text = "Difficulty (" + GameData.DIFFICULTY.keys()[diff] + ")"
	
func _on_easy_button_button_up() -> void:
	GameData.SetDifficulty(GameData.DIFFICULTY.EASY)


func _on_medium_button_button_up() -> void:
	GameData.SetDifficulty(GameData.DIFFICULTY.MEDIUM)


func _on_difficult_button_button_up() -> void:
	GameData.SetDifficulty(GameData.DIFFICULTY.HARD)
