extends Panel

@onready var PurchaseContainer = $Panel/HBoxContainer

enum UPGRADE_STATE {
	CHARACTER_UPGRADES,
	CHARACTER_UNLOCK
}

var CurrentUpgradeState = UPGRADE_STATE.CHARACTER_UPGRADES

var UpgradeableCharacters = []

var CharactersToUnlock = []
var CurrentCharacters =[]

func _ready() -> void:
	Finder.GetEXPBar().OnLevelUp.connect(OnLevelup)
	Finder.GetGame().OnGameOver.connect(OnGameOver)
	CharactersToUnlock = Helper.GetAllFilePaths("res://Content/CharacterPools/Common/")
	CharactersToUnlock.shuffle()
	
func OnGameOver():
	if visible:
		Close()
func OnLevelup():
	Setup()

func Setup():
	get_tree().paused = true
	Jukebox.PlayMusic(JukeboxPlayer.MUSIC_TYPE.SHOP)
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
	


func DetermineUpgradeState():
	if UpgradeableCharacters.size() > 0:		
		if CurrentCharacters.size() >= 6:
			CurrentUpgradeState = UPGRADE_STATE.CHARACTER_UPGRADES
			return
		else:
			var value = randf_range(0, 100)
			if value <= 50:
				CurrentUpgradeState = UPGRADE_STATE.CHARACTER_UNLOCK
			
	else:
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
	
func CreateCharacterUpgrade(char : BaseCharacter):
	var instance = load("res://Prefabs/UI/PurchaseButton.tscn").instantiate()
	PurchaseContainer.add_child(instance)
	instance.OnPurchased.connect(OnPurchased)
	instance.Setup(char)
	
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
	
func Close():
	visible = false
	Cleanup()
	get_tree().paused = false
	Jukebox.PlayMusic(JukeboxPlayer.MUSIC_TYPE.FIGHT)
