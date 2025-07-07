extends Node2D

@export_dir var WavesDirectory

var Waves = []
var Round = 0
func _ready() -> void:
	Waves = Helper.GetAllFilePaths(WavesDirectory)
	print(Waves)
	SpawnNextWave()
	
func SpawnNextWave():
	if Waves.size() > 0:
		var newWave = load(Waves.pop_front()) as EnemyWaveData
		Round += 1
		
		Finder.GetGame().OnRoundUpdate.emit(Round, newWave.bIsBossWave)
		await newWave.CreateEnemies()
		print(newWave.resource_path + " START")
		$Timer.start()
	else:
		print("Game Over!")
		Waves = Helper.GetAllFilePaths(WavesDirectory)
		SpawnNextWave()
		


func _on_timer_timeout() -> void:
	if Finder.GetEnemyGroup().get_child_count() <= 0:
		$Timer.stop()
		
		
		for x in range(0, Round):
			var spawnPosition = Helper.GetRandomPositionAroundPoint(Finder.GetPlayer().GetPlayerPosition(),
			200)
			Helper.DropEXPOrb(200, spawnPosition)
		
		SpawnNextWave()
		
