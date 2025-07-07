extends Resource

class_name EnemyWaveData

@export var EnemyWavePairings : Array[EnemyWavePairingData]
@export var bIsBossWave = false

func CreateEnemies():
	if bIsBossWave:
		Jukebox.ChangeFightMusic(load("res://Audio/Music/bosstheme (1).ogg"))
	else:
		Jukebox.ChangeFightMusic(load("res://Audio/Music/level25-battle (1).ogg"))
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
	return Helper.GetRandomPositionAroundPoint(Finder.GetPlayer().GetPlayerPosition(), 800)
