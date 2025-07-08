extends Node2D

@export_dir var WavesDirectory

var Waves = []
var Round = 0

var CurrentWave : EnemyBaseWaveData
func _ready() -> void:
	Waves = Helper.GetAllFilePaths(WavesDirectory)
	print(Waves)
	await get_tree().create_timer(.3).timeout
	SpawnNextWave()
	
func SpawnNextWave():
	if Waves.size() > 0:
		var newWave = load(Waves.pop_front()) as EnemyBaseWaveData
		Round += 1
		CurrentWave = newWave
		Finder.GetGame().OnRoundUpdate.emit(Round, newWave.GetWaveText())
		await newWave.CreateEnemies()
		print(newWave.resource_path + " START")
		$Timer.start()
	else:
		print("Game Over!")
		Waves = Helper.GetAllFilePaths(WavesDirectory)
		SpawnNextWave()
		


func _on_timer_timeout() -> void:
	if CurrentWave.CanContinue() == false:
		$Timer.stop()		
		for x in range(0, Round):
			var spawnPosition = Helper.GetRandomPositionAroundPoint(Finder.GetPlayer().GetPlayerPosition(),
			200)
			Helper.DropEXPOrb(200, spawnPosition)
		
		SpawnNextWave()
		
