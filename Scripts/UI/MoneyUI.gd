extends HBoxContainer

class_name MoneyUI
enum TYPE {
	REGULAR,
	COST
}
@export var MoneyUIType : TYPE

func _ready() -> void:
	if MoneyUIType == TYPE.REGULAR:
		Finder.GetGame().OnMoneyUpdate.connect(OnMoneyUpdate)
		OnMoneyUpdate()
func OnMoneyUpdate():
	Update(Finder.GetGame().GetMoney())
	
func Update(amount):
	$Label.text = str(amount)
	if MoneyUIType == TYPE.REGULAR:
		$Label.modulate = Color.WHITE
	else:
		if Finder.GetGame().GetMoney() >= amount:
			$Label.modulate = Color.WHITE
		else:
			$Label.modulate = Color.RED
	
