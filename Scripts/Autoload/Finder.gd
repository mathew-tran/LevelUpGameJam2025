extends Node

func GetPlayer() -> Player:
	return get_tree().get_nodes_in_group("Player")[0]
	
func GetSpawnPoints():
	return get_tree().get_nodes_in_group("SpawnPoints")[0]
	
func GetSpawner() -> Spawner:
	return get_tree().get_nodes_in_group("Spawner")[0]
	
func GetEXPBar() -> EXPBar:
	return get_tree().get_nodes_in_group("EXPBar")[0]
	
func GetBulletsGroup():
	return get_tree().get_nodes_in_group("Bullets")[0]

func GetSubBulletsGroup():
	return get_tree().get_nodes_in_group("SubBullets")[0]
	
func GetRerollButton():
	return get_tree().get_nodes_in_group("Reroll")[0]
	
func GetEffectGroup():
	return get_tree().get_nodes_in_group("EffectGroup")[0]

func GetGame() -> Game:
	return get_tree().get_nodes_in_group("Game")[0]

func GetLevelUp() -> Levelup:
	return get_tree().get_nodes_in_group("Levelup")[0]
	
func GetPickupGroup():
	return get_tree().get_nodes_in_group("PickupGroup")[0]
	
func GetEXP() -> EXPBar:
	return get_tree().get_nodes_in_group("EXPBar")[0]
	
func GetEnemyGroup():
	var result = get_tree().get_nodes_in_group("EnemyGroup")
	if result:
		return result[0]
	return null


func GetClosestEnemy(fromPosition, range = 500):
	var enemies = GetEnemyGroup().get_children()
	if enemies.size() > 0:
		var closestEnemy = enemies[0]
		var closestDistance = 999999
		for index in range(0, enemies.size()):
			var distanceToEnemy = enemies[index].global_position.distance_to(fromPosition)
			if distanceToEnemy < closestDistance:
				if distanceToEnemy <= range:
					closestDistance = distanceToEnemy
					closestEnemy = enemies[index]
			else:
				pass
		if closestDistance > range:
			return null
		return closestEnemy
	return null


func GetWorkerGroup():
	return get_tree().get_nodes_in_group("WorkerGroup")[0]
	
func GetClosestWorker(fromPosition):
	var worker = GetWorkerGroup().get_children()
	if worker.size() > 0:
		var closestWorker = worker[0]
		var closestDistance = 9999999
		for index in range(0, worker.size()):
			var distanceToEnemy = worker[index].global_position.distance_to(fromPosition)
			if distanceToEnemy < closestDistance:
				closestDistance = distanceToEnemy
				closestWorker = worker[index]
		return closestWorker
	return null
