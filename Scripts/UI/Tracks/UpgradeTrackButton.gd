extends Button

@export var UpgradeCost = 5

func Update():
	var money = Finder.GetGame().GetMoney()
	$HBoxContainer2/HBoxContainer.Update(UpgradeCost)
	disabled = money < UpgradeCost
