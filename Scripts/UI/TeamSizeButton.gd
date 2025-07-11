extends Button

var Cost = 4

func _ready() -> void:
	Finder.GetGame().OnMoneyUpdate.connect(OnMoneyUpdate)
	Finder.GetEXPBar().OnLevelUp.connect(OnLevelup)
	OnLevelup()
	
func OnLevelup():
	OnMoneyUpdate()
	
func OnMoneyUpdate():
	$HBoxContainer/MoneyText.Update(Cost)
	if Finder.GetLevelUp().CanIncreaseTeamSize() == false:
		visible = false


func _on_button_up() -> void:
	if Cost <= Finder.GetGame().GetMoney():
		Jukebox.PlaySFXMenu(load("res://Audio/SFX/MenuSelect.wav"))
		Finder.GetLevelUp().IncreaseCharacterAmount()
		Finder.GetLevelUp().Setup()
		Finder.GetGame().RemoveMoney(Cost)
		Cost += 3
		OnMoneyUpdate()


func _on_mouse_entered() -> void:
	Jukebox.PlaySFXMenu(load("res://Audio/SFX/Menuhover.wav"))
