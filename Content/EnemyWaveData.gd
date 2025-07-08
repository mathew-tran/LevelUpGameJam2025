extends EnemyBaseWaveData

class_name EnemyWaveData

@export var EnemyWavePairings : Array[EnemyWavePairingData]
@export var bIsBossWave = false
@export var WaveType : WAVE_TYPE
@export var TimeBetweenSpawn = -1.0

func CreateEnemies():
	if bIsBossWave:
		Jukebox.ChangeFightMusic(load("res://Audio/Music/bosstheme (1).ogg"))
	else:
		Jukebox.ChangeFightMusic(load("res://Audio/Music/level25-battle (1).ogg"))
		
	var enemyCount = 0
	for wave in EnemyWavePairings:
		enemyCount += wave.AmountToSpawn
		
	var positions = MakeSpawnPositions(enemyCount, WaveType)
	positions.shuffle()
	var spawnPositions = []
	var enemiesSpawned = []
	for wave in EnemyWavePairings:
		var enemyClass = load(wave.GetEnemyPath())
		
		for x in range(0, wave.AmountToSpawn):
			var instance = enemyClass.instantiate()
			instance.global_position = positions.pop_front()
			Finder.GetEnemyGroup().add_child(instance)
			enemiesSpawned.append(instance)
			if TimeBetweenSpawn > 0:
				await Finder.GetPlayer().get_tree().create_timer(TimeBetweenSpawn).timeout

			
			
func GetSpawnPosition():
	return Helper.GetRandomPositionAroundPoint(Finder.GetPlayer().GetPlayerPosition(), 800)

func CanContinue():
	return Finder.GetEnemyGroup().get_child_count() > 0
	
func GetWaveText():
	if bIsBossWave:
		return "BOSS WAVE"
	return ""
