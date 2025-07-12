extends TextureRect

func Setup(character : CharacterData):
	texture = character.Picture
	$Panel.self_modulate = CharacterData.GetDepartmentColor(character.Occupation)
	
