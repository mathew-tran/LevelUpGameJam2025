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
		var amount = Round + 6 + randi() % 10
		if amount >= 100:
			amount = 100
		var expPerOrb = (Round + 1) * 10
		var increments = 360 / amount
		for x in range(0, amount):
			await get_tree().create_timer(.1).timeout
			var spawnPosition = Helper.GetPositionAroundPoint(Finder.GetPlayer().GetPlayerPosition(), 200,
			increments * x)
			await Helper.DropEXPOrbMoveFromXtoY(expPerOrb, global_position, spawnPosition, .05)
		
		SpawnNextWave()
		
