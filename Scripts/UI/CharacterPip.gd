extends TextureRect

func Setup(character : BaseCharacter):
	texture = character.CharacterDataRef.Picture
	$Label.text = "Lv" + str(character.CharacterLevel)
	$Panel.self_modulate = CharacterData.GetDepartmentColor(character.CharacterDataRef.Occupation)
	
