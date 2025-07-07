extends Resource

class_name CharacterData

@export var Name = ""
@export var Occupation : DEPARTMENT
@export var Cost = 10
@export var Description = ""
@export var Picture : Texture2D
@export var Projectile : PackedScene
@export var Spread = 1
@export var AttackSpeed = 1.0 # per second
@export var Damage = 5
@export var ProjectileSpeed = 5
@export var Penetration = 0

@export var BulletSpread : BULLET_SPREAD
@export var ShootType : SHOOT_TYPE
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
enum BULLET_SPREAD {
	NORMAL,
	RADIAL
}

enum SHOOT_TYPE {
	SINGLE_SHOT,
	DOUBLE_SHOT,
	TRIPLE_SHOT
}

func GetOccupationString():
	var str = "from " + str(DEPARTMENT.keys()[Occupation])
	return str

func Create():
	var instance = load("res://Prefabs/Characters/BaseCharacter.tscn").instantiate()
	instance.global_position = Finder.GetPlayer().GetPlayerPosition()
	instance.CharacterDataRef = self
	Finder.GetWorkerGroup().add_child(instance)

	
	
