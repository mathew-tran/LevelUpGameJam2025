extends Button

var RerollCost = 3
var DefaultCost = 3

func _ready() -> void:
	Finder.GetGame().OnMoneyUpdate.connect(OnMoneyUpdate)
	Finder.GetEXPBar().OnLevelUp.connect(OnLevelup)
	OnLevelup()
	
func OnLevelup():
	RerollCost = DefaultCost
	OnMoneyUpdate()
	
func OnMoneyUpdate():
	$HBoxContainer/MoneyText.Update(RerollCost)


func _on_button_up() -> void:
	if RerollCost <= Finder.GetGame().GetMoney():
		Jukebox.PlaySFXMenu(load("res://Audio/SFX/MenuSelect.wav"))
		Finder.GetLevelUp().Setup()
		Finder.GetGame().RemoveMoney(RerollCost)
		RerollCost += 2
		OnMoneyUpdate()
		GameData.AddData("Rerolls", 1)


func _on_mouse_entered() -> void:
	Jukebox.PlaySFXMenu(load("res://Audio/SFX/Menuhover.wav"))
