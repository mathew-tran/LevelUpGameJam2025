extends Node2D

@export_dir var WavesDirectory

var Waves = []
func _ready() -> void:
	Waves = Helper.GetAllFilePaths(WavesDirectory)
	SpawnNextWave()
	
func SpawnNextWave():
	if Waves.size() > 0:
		var newWave = load(Waves.pop_front()) as EnemyWaveData
		await newWave.CreateEnemies()
		print(newWave.resource_path + " START")
		$Timer.start()
	else:
		print("Game Over!")
		$Timer.stop()
		


func _on_timer_timeout() -> void:
	if Finder.GetEnemyGroup().get_child_count() <= 0:
		SpawnNextWave()
		$Timer.stop()
