extends HBoxContainer

@export var Category : CharacterData.DEPARTMENT

@export var Upgrades : Array[TrackUpgradeData]

@onready var UpgradeContainer = $HBoxContainer

var Index = 0
var MaxIndex = -1
func _ready() -> void:
	Finder.GetGame().OnInvestDepartment.connect(OnInvestDepartment)
	Finder.GetGame().OnMoneyUpdate.connect(OnMoneyUpdate)
	$Label.text = CharacterData.DEPARTMENT.keys()[Category]
	$Level.text = str(Index) 
	$Level/Button.Update()
	Update()
	
func OnMoneyUpdate():
	$Level/Button.Update()

	
func OnInvestDepartment(department):
	if department == Category:
		Increment()
		
func Increment():
	if Index < MaxIndex:
		UpgradeContainer.get_child(Index).Activate()
		GameData.AddData("Track Levels Gained", 1)
		Index += 1
		$Level.text = str(Index) 
		if Index >= MaxIndex:
			$Level/Button.visible = false
		
func Update():
	for child in UpgradeContainer.get_children():
		child.queue_free()
		
	await get_tree().process_frame
	
	var pipClass = load("res://Prefabs/UI/Tracks/TrackUpgradePip.tscn")
	
	for upgrade in Upgrades:
		var instance = pipClass.instantiate()
		UpgradeContainer.add_child(instance)
		instance.Setup(upgrade, CharacterData.GetDepartmentColor(Category))
	
	MaxIndex = len(Upgrades)


func _on_button_button_up() -> void:
	Finder.GetGame().RemoveMoney($Level/Button.UpgradeCost)
	Jukebox.PlaySFXMenu(load("res://Audio/SFX/levelup25-purchase.wav"))
	GameData.AddData("Track Purchases", 1)
	Increment()
