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
		Finder.GetLevelUp().Setup()
		Finder.GetGame().RemoveMoney(RerollCost)
		RerollCost += 2
		OnMoneyUpdate()
