extends Node2D

var MaxEnemyCount = 100
func _on_timer_timeout() -> void:
	SpawnEnemies()

func SpawnEnemies():
	var enemiesToSpawn = 100
	var currentEnemies = Finder.GetEnemyGroup().get_children().size()
	enemiesToSpawn = clamp(enemiesToSpawn, 0, MaxEnemyCount - currentEnemies)
		
	var playerPosition = Finder.GetPlayer().GetPlayerPosition()
	var distanceAwayFromPlayer = 800
	var direction = Vector2.RIGHT
	for x in range(0, enemiesToSpawn):
		var instance = load("res://Prefabs/Enemies/BaseEnemy.tscn").instantiate()
		instance.global_position = playerPosition + direction.rotated(randf_range(0, 360)) * distanceAwayFromPlayer
		Finder.GetEnemyGroup().add_child(instance)
		
