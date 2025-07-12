extends EnemyBaseWaveData

class_name EnemySurviveWaveData

@export var SurviveTimeLimit = 20.0
@export var PollTime = 3
@export var EnemyLimit = 100
@export var EnemiesToSpawn : Array[EnemyWavePairingData]
@export var WaveFormation : EnemyWaveData.WAVE_TYPE
func CreateEnemies():
		Finder.GetGame().SetTimer(SurviveTimeLimit)
		Jukebox.ChangeFightMusic(load("res://Audio/Music/BattleSong2 (1).ogg"))
		while Finder.GetGame().IsTimerDone() == false:
			var index = 0
			await Finder.GetGame().get_tree().create_timer(PollTime).timeout
			if Finder.GetEnemyGroup() == null:
				return
			while index < len(EnemiesToSpawn) and Finder.GetEnemyGroup().get_child_count() < EnemyLimit:
				var enemyClass =  load(EnemiesToSpawn[index].GetEnemyPath())
				var positions = MakeSpawnPositions(EnemiesToSpawn[index].AmountToSpawn, WaveFormation)
				for x in range(0, EnemiesToSpawn[index].AmountToSpawn):
					var instance = enemyClass.instantiate()
					instance.global_position = positions[x]
					Finder.GetEnemyGroup().add_child(instance)
				index += 1
	
func CanContinue():
	return Finder.GetGame().IsTimerDone() == false or Finder.GetEnemyGroup().get_child_count() > 0

func GetWaveText():
		return "SURVIVE"
	
