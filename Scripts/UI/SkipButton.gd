extends Button

var MoneyToGain =  1
func _ready() -> void:
	Finder.GetLevelUp().OnLevelUpMenuOpened.connect(OnLevelUpMenuOpened)
	
func OnLevelUpMenuOpened():
	if Finder.GetGame().bExtraMoneyOnSkip:
		MoneyToGain = 2
		$HBoxContainer2/Label.text = "(+2"
		
func _on_button_up() -> void:
	Finder.GetGame().AddMoney(MoneyToGain)
	Finder.GetLevelUp().Close()
	Jukebox.PlaySFXMenu(load("res://Audio/SFX/MenuSelect.wav"))
	GameData.AddData("Skips", 1)

func _on_mouse_entered() -> void:
	Jukebox.PlaySFXMenu(load("res://Audio/SFX/Menuhover.wav"))
