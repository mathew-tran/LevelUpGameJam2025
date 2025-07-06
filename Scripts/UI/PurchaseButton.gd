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
	$TextureRect.texture = charData.Picture
	$Level.text = ""
	
func Setup(character : BaseCharacter):
	CharacterToApply = character
	
	var nextUpgrade = character.GetNextUpgrade()
	UpgradeToMake = nextUpgrade
	
	$Label.text = nextUpgrade.GetUpgradeName()
	$TextureRect.texture = character.CharacterDataRef.Picture
	$Level.text = "LV" + str(character.CharacterLevel + 1)
	$Name.text = character.CharacterDataRef.Name + " " +  character.CharacterDataRef.GetOccupationString()
	
func _on_button_up() -> void:
	Jukebox.PlaySFXMenu(load("res://Audio/SFX/levelup25-purchase.wav"))
	if is_instance_valid(UpgradeToMake):
		UpgradeToMake.Apply(CharacterToApply)
	elif is_instance_valid(CharacterToAdd):
		CharacterToAdd.Create()
		Finder.GetGame().RemoveCharacterFromGame(CharacterToAdd.Name)
	OnPurchased.emit()
