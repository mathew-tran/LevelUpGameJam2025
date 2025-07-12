extends CanvasLayer

@onready var CharacterButtonContainer = $GridContainer
@onready var ChosenCharacter = $ChosenCharacter
@onready var ContinueButton = $ContinueButton
var CharData : CharacterData
func _ready() -> void:
	get_tree().paused = false
	Setup()
	Jukebox.PlayMusic(JukeboxPlayer.MUSIC_TYPE.SHOP)
	if GameData.ChosenCharacter:
		OnClicked(GameData.ChosenCharacter)

func Setup():
	for child in CharacterButtonContainer.get_children():
		child.queue_free()
	await get_tree().process_frame
	
	var charSelectButton = load("res://Prefabs/UI/CharacterSelect/CharacterSelectButton.tscn")
	var charactersToUnlock = Helper.GetAllFilePaths("res://Content/CharacterPools/Common/")
	for character in charactersToUnlock:
		var instance = charSelectButton.instantiate()
		CharacterButtonContainer.add_child(instance)	
		instance.Setup(load(character))
		instance.OnClicked.connect(OnClicked)
		
func OnClicked(charData : CharacterData):
	CharData = charData
	ChosenCharacter.texture = charData.Picture
	$ChosenCharacter/Panel.visible = false
	$ContinueButton.visible = true
	$CharacterInfo/Name.text = CharData.Name
	$CharacterInfo/Occupation.text = CharData.GetOccupationString()
	$CharacterInfo/Description.text = charData.Description
	$CharacterInfo/Panel.modulate = CharacterData.GetDepartmentColor(charData.Occupation)
	$CharacterInfo.visible = true
	Jukebox.PlaySFXMenu(load("res://Audio/SFX/MenuSelect.wav"))
	
	for character in CharacterButtonContainer.get_children():
		character.SetEnabled(character.CharRefData == CharData)


func _on_continue_button_button_up() -> void:
	GameData.ChosenCharacter = CharData
	Jukebox.PlaySFXMenu(load("res://Audio/SFX/levelup25-purchase.wav"))
	get_tree().change_scene_to_packed(load("res://Scene/Main.tscn"))
