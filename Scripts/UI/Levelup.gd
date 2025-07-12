extends Panel

class_name Levelup

@onready var PurchaseContainer = $Panel/HBoxContainer

enum UPGRADE_STATE {
	CHARACTER_UPGRADES,
	CHARACTER_UNLOCK,
	WEAK_UPGRADES,
	SKIP
}

var CurrentUpgradeState = UPGRADE_STATE.CHARACTER_UPGRADES

var UpgradeableCharacters = []

var CharactersToUnlock = []
var CurrentCharacters =[]

var MaxCharacterAmount = 2
var HiddenMaxCharacterAmount = 0

signal OnIncreaseCharacterAmount
signal OnLevelUpMenuOpened

func IncreaseCharacterAmount():
	MaxCharacterAmount += 1
	OnIncreaseCharacterAmount.emit()
	if MaxCharacterAmount >= HiddenMaxCharacterAmount:
		MaxCharacterAmount = HiddenMaxCharacterAmount

func CanIncreaseTeamSize():
	return MaxCharacterAmount < HiddenMaxCharacterAmount
	
func GetCharacterCountString():
	var playerAmount = Finder.GetWorkerGroup().get_children().size()
	return  str(playerAmount) + "/" + str(MaxCharacterAmount)
	
func _enter_tree() -> void:
	CharactersToUnlock = Helper.GetAllFilePaths("res://Content/CharacterPools/Common/")
	CharactersToUnlock.shuffle()
	HiddenMaxCharacterAmount = 6
	
func _ready() -> void:
	Finder.GetEXPBar().OnLevelUp.connect(OnLevelup)
	Finder.GetGame().OnGameOver.connect(OnGameOver)
	Finder.GetGame().OnRemoveCharFromGame.connect(OnRemoveCharFromGame)
	Finder.GetGame().OnAddCharToGame.connect(OnAddBackCharToGame)

	
func OnGameOver():
	await get_tree().create_timer(.1).timeout
	if visible:
		Close()
		
func OnLevelup():
	if Finder.GetGame().IsGameFinished():
		return
	Finder.GetGame().SetGameState(Game.GAME_STATE.LEVELUP)
	if Finder.GetEXPBar().Level % 5 == 0:
		Finder.GetGame().AddMoney(1)
	Setup()
	if Finder.GetGame().bHealOnLevelup:
		for child in Finder.GetWorkerGroup().get_children():
			child.Heal(2)

func Setup():

	if GameData.bFirstLevelup:
		await get_tree().create_timer(.5).timeout
		var data = {}
		data["message"] = "Click this button to increase your team size!"
		data["img"] = load("res://Art/ExampleImg/Helpr.png")
		InfoPopup.ShowPopup(data)
		GameData.bFirstLevelup = false
	OnLevelUpMenuOpened.emit()
	if get_tree().paused == false:
		get_tree().paused = true
		Jukebox.PlayMusic(JukeboxPlayer.MUSIC_TYPE.SHOP)
		$AudioStreamPlayer2D.play()
	await Cleanup()
	var characters = Finder.GetWorkerGroup().get_children()
	UpgradeableCharacters.clear()
	CurrentCharacters.clear()
	CurrentCharacters = characters
	for x in range(0, characters.size()):
		if characters[x].GetNextUpgrade():
			UpgradeableCharacters.append(characters[x])
		
	DetermineUpgradeState()
	UpgradeableCharacters.shuffle()
	
	match CurrentUpgradeState:
		UPGRADE_STATE.CHARACTER_UPGRADES:
			CreateCharacterUpgrades()
		UPGRADE_STATE.CHARACTER_UNLOCK:
			CreateCharacterUnlocks()
		UPGRADE_STATE.WEAK_UPGRADES:
			CreateWeakUpgrades()
		UPGRADE_STATE.SKIP:
			Close()
			
	print(UPGRADE_STATE.keys()[CurrentUpgradeState] + " was selected")

func HasUpgradeableCharacters():
	return UpgradeableCharacters.size() > 0
	
func HasMoreCharacters():
	return CharactersToUnlock.size() > 0
	
func HasFullTeam():
	return CurrentCharacters.size() >= MaxCharacterAmount
	
func DetermineUpgradeState():
	if HasUpgradeableCharacters() == false and HasFullTeam():
			# should provide weak upgrades
			CurrentUpgradeState = UPGRADE_STATE.WEAK_UPGRADES
			return
		
	if HasUpgradeableCharacters() and HasFullTeam():
		CurrentUpgradeState = UPGRADE_STATE.CHARACTER_UPGRADES
		return
		
	if HasUpgradeableCharacters() and HasFullTeam() == false:	
		CurrentUpgradeState = UPGRADE_STATE.CHARACTER_UPGRADES
		if HasMoreCharacters():
			var value = randf_range(0, 100)
			if value <= 50:
				CurrentUpgradeState = UPGRADE_STATE.CHARACTER_UNLOCK
		else:
			CurrentUpgradeState = UPGRADE_STATE.CHARACTER_UPGRADES
		return
	if HasFullTeam() == false:
		CurrentUpgradeState = UPGRADE_STATE.CHARACTER_UNLOCK

func CreateCharacterUpgrades():
	var characters = Finder.GetWorkerGroup().get_children()
	var upgradeAmount = 0
	upgradeAmount = clamp(UpgradeableCharacters.size(), 0, 3)
	
	var index = 0
	if UpgradeableCharacters.size():
		while upgradeAmount > 0:
			CreateCharacterUpgrade(UpgradeableCharacters[index])
			index += 1
			upgradeAmount -= 1
	visible = true
		
func CreateWeakUpgrades():
	CurrentCharacters.shuffle()
	var upgradeAmount = CurrentCharacters.size()
	if upgradeAmount > 3:
		upgradeAmount = 3
	var index = 0
	while upgradeAmount > 0:
		CreateCharacterUpgrade(CurrentCharacters[index], false)
		index += 1
		upgradeAmount -= 1
	
	visible = true
	
func CreateCharacterUnlocks():
	var characterAmount = 3
	var index = 0
	CharactersToUnlock.shuffle()

	while characterAmount > 0:
		if CharactersToUnlock.size() > index:
			var data = {}
			data["path"] = CharactersToUnlock[index]
			CreateCharacterUnlock(data)
			index += 1
		characterAmount -= 1

	visible = true
	
func CreateCharacterUpgrade(char : BaseCharacter, bUseNext = true):
	var instance = load("res://Prefabs/UI/PurchaseButton.tscn").instantiate()
	PurchaseContainer.add_child(instance)
	instance.OnPurchased.connect(OnPurchased)
	instance.Setup(char, bUseNext)
	
func CreateCharacterUnlock(data):
	var instance = load("res://Prefabs/UI/PurchaseButton.tscn").instantiate()
	PurchaseContainer.add_child(instance)
	instance.OnPurchased.connect(OnPurchased)
	instance.SetupCharUnlock(data)
	
func Cleanup():
	for child in PurchaseContainer.get_children():
		child.queue_free()
	await get_tree().create_timer(.1).timeout
	
func OnPurchased():
	Close()
	
func OnRemoveCharFromGame(char):
	var index = 0
	for x in CharactersToUnlock:
		if char.to_lower() in x.to_lower():
			CharactersToUnlock.remove_at(index)
			break
		index += 1
	print("remaining characters" + str(CharactersToUnlock))
	
func OnAddBackCharToGame(resourcePath):
	CharactersToUnlock.append(resourcePath)
	
func Close():
	visible = false
	Cleanup()
	get_tree().paused = false
	Jukebox.PlayMusic(JukeboxPlayer.MUSIC_TYPE.FIGHT)
	Finder.GetGame().SetGameState(Game.GAME_STATE.PlAYING)


func _on_button_button_up() -> void:
	$Tracks.visible = !$Tracks.visible
	pass # Replace with function body.
