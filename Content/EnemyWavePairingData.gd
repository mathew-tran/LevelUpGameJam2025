extends Resource

class_name EnemyWavePairingData

enum ENEMY_TYPE {
	WEAK_A,
	WEAK_B,
}
@export var EnemyTypeToSpawn : ENEMY_TYPE
@export var AmountToSpawn = 20


func GetEnemyPath():
	match EnemyTypeToSpawn:
		ENEMY_TYPE.WEAK_A:
			return "res://Prefabs/Enemies/EnemyStickyNote.tscn"
		ENEMY_TYPE.WEAK_B:
			return "res://Prefabs/Enemies/BaseEnemy.tscn"
