extends Resource

class_name CharacterData

@export var Name = ""
@export var Occupation : DEPARTMENT
@export var Cost = 10
@export var Description = ""
@export var Picture : Texture2D
@export var Projectile : PackedScene

@export var Upgrades : Array[CharacterUpgradeData]

enum DEPARTMENT {
	ACCOUNTING,
	SECURITY,
	DEVELOPMENT,
	ART,
	AUDIO,
	MARKETING,
	QA
}

func GetOccupationString():
	var str = "from " + str(DEPARTMENT.keys()[Occupation])
	return str

func Create():
	var instance = load("res://Prefabs/Characters/Base.tscn").instantiate()
	instance.global_position = Finder.GetPlayer().GetPlayerPosition()
	Finder.GetWorkerGroup().add_child(instance)

	instance.Setup(self)
	
