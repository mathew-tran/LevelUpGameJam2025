extends Resource

class_name EnemyWaveData

@export var EnemyWavePairings : Array[EnemyWavePairingData]

func CreateEnemies():
	var enemiesSpawned = []
	for wave in EnemyWavePairings:
		var enemyClass = load(wave.GetEnemyPath())
		var spawnPosition = GetSpawnPosition()
		var defaultClumpAmount = 1
		var clumpAmount = defaultClumpAmount
		
		for x in range(0, wave.AmountToSpawn):
			var instance = enemyClass.instantiate()
			instance.global_position = spawnPosition
			Finder.GetEnemyGroup().add_child(instance)
			enemiesSpawned.append(instance)
			clumpAmount -= 1
			if clumpAmount <= 0:
				clumpAmount = defaultClumpAmount + randi_range(1,5)
				spawnPosition = GetSpawnPosition()
	return enemiesSpawned
			
			
func GetSpawnPosition():
		var playerPosition = Finder.GetPlayer().GetPlayerPosition()
		var distanceAwayFromPlayer = 800
		var direction = Vector2.RIGHT
		return playerPosition + direction.rotated(randf_range(0, 360)) * distanceAwayFromPlayer
			
