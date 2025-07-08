extends HBoxContainer

@export var Category : CharacterData.DEPARTMENT

@export var Upgrades : Array[TrackUpgradeData]

@onready var UpgradeContainer = $HBoxContainer

var Index = 0
var MaxIndex = -1
func _ready() -> void:
	Finder.GetGame().OnInvestDepartment.connect(OnInvestDepartment)
	$Label.text = CharacterData.DEPARTMENT.keys()[Category]
	Update()
	
func OnInvestDepartment(department):
	if department == Category:
		Increment()
		
func Increment():
	if Index < MaxIndex:
		UpgradeContainer.get_child(Index).Activate()
		Index += 1
		
func Update():
	for child in UpgradeContainer.get_children():
		child.queue_free()
		
	await get_tree().process_frame
	
	var pipClass = load("res://Prefabs/UI/Tracks/TrackUpgradePip.tscn")
	
	for upgrade in Upgrades:
		var instance = pipClass.instantiate()
		UpgradeContainer.add_child(instance)
		instance.Setup(upgrade)
	
	MaxIndex = len(Upgrades)
