extends Resource

class_name EnemyWavePairingData

enum ENEMY_TYPE {
	WEAK_A,
	WEAK_B,
	FAST_A,
	MINIBOSS,
	MEDIUM_A,
	MINIBOSS_2,
	FINAL_BOSS
}
@export var EnemyTypeToSpawn : ENEMY_TYPE
@export var AmountToSpawn = 20


func GetEnemyPath():
	match EnemyTypeToSpawn:
		ENEMY_TYPE.WEAK_A:
			return "res://Prefabs/Enemies/EnemyStickyNote.tscn"
		ENEMY_TYPE.MEDIUM_A:
			return "res://Prefabs/Enemies/EnemyStickyNote2.tscn"
		ENEMY_TYPE.WEAK_B:
			return "res://Prefabs/Enemies/BaseEnemy.tscn"
		ENEMY_TYPE.FAST_A:
			return "res://Prefabs/Enemies/EnemyDisk.tscn"
		ENEMY_TYPE.MINIBOSS:
			return "res://Prefabs/Enemies/EnemyComputer.tscn"
		ENEMY_TYPE.MINIBOSS_2:
			return "res://Prefabs/Enemies/EnemyCalculator.tscn"
		ENEMY_TYPE.FINAL_BOSS:
			return "res://Prefabs/Enemies/EnemyBlueScreen.tscn"
