extends HBoxContainer

func _ready() -> void:
	Finder.GetLevelUp().OnIncreaseCharacterAmount.connect(OnIncreaseCharacterAmount)
	Finder.GetLevelUp().OnLevelUpMenuOpened.connect(OnLevelUpMenuOpened)


func Update():
	$Label.text = Finder.GetLevelUp().GetCharacterCountString()
	
func OnIncreaseCharacterAmount():
	Update()

func OnLevelUpMenuOpened():
	Update()	
