extends Resource

class_name CharacterData

@export var Name = ""
@export var Occupation : DEPARTMENT
@export var Description = ""
@export var Picture : Texture2D

@export_category("Voice")
@export var Voice : AudioStream
@export var Pitch = 1.0
@export var WelcomePhrase = ""
@export var UpgradePhrases : Array[String]
@export var DeathPhrase : Array[String]

@export_category("Stats")
@export var Projectile : PackedScene
@export var Spread = 1
@export var AttackSpeed = 1.0 # per second
@export var Damage = 5
@export var ProjectileSpeed = 5
@export var Penetration = 0

@export var BulletSpread : BULLET_SPREAD
@export var ShootType : SHOOT_TYPE

@export_category("Upgrades")
@export var Upgrades : Array[CharacterUpgradeData]
@export var WeakUpgrades : Array[CharacterUpgradeData]


enum DEPARTMENT {
	DEVELOPMENT,
	ART,
	AUDIO,
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

	
	
