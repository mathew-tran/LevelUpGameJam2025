extends Button

signal OnPurchased

var UpgradeToMake : CharacterUpgradeData
var CharacterToApply : BaseCharacter
var CharacterToAdd : CharacterData

func SetupCharUnlock(data : Dictionary):
	var charData = load(data["path"]) as CharacterData
	CharacterToAdd = charData
	$Label.text = charData.Description
	$Name.text = charData.Name + " " +  charData.GetOccupationString()
	$Name.modulate = charData.GetDepartmentColor(charData.Occupation)
	$TextureRect.texture = charData.Picture
	$Level.text = ""
	
func Setup(character : BaseCharacter, bUseNext = true):
	CharacterToApply = character
	
	var nextUpgrade = character.GetNextUpgrade()
	if bUseNext == false:
		nextUpgrade = character.GetNextWeakUpgrade()
	UpgradeToMake = nextUpgrade
	
	$Label.text = nextUpgrade.GetUpgradeName()
	$TextureRect.texture = character.CharacterDataRef.Picture
	$Level.text = "LV" + str(character.CharacterLevel + 1)
	$Name.text = character.CharacterDataRef.Name + " " +  character.CharacterDataRef.GetOccupationString()
	$Name.modulate = CharacterData.GetDepartmentColor(character.CharacterDataRef.Occupation)
	
func _on_button_up() -> void:
	Jukebox.PlaySFXMenu(load("res://Audio/SFX/levelup25-purchase.wav"))
	if is_instance_valid(UpgradeToMake):
		UpgradeToMake.Apply(CharacterToApply)
		Finder.GetGame().OnInvestDepartment.emit(CharacterToApply.CharacterDataRef.Occupation)
		GameData.AddData("Coworker Upgrades", 1)
	elif is_instance_valid(CharacterToAdd):
		CharacterToAdd.Create()
		GameData.AddData("Coworker Hires", 1)
		Finder.GetGame().OnInvestDepartment.emit(CharacterToAdd.Occupation)
	OnPurchased.emit()
	


func _on_mouse_entered() -> void:
	Jukebox.PlaySFXMenu(load("res://Audio/SFX/Menuhover.wav"))
	pass # Replace with function body.
