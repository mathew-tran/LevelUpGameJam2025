extends Node

func GetBulletsGroup():
	return get_tree().get_nodes_in_group("Bullets")[0]

func GetEnemyGroup():
	return get_tree().get_nodes_in_group("EnemyGroup")[0]

func GetClosestEnemy(fromPosition):
	var enemies = GetEnemyGroup().get_children()
	if enemies.size() > 0:
		var closestEnemy = enemies[0]
		var closestDistance = 9999999999999999999
		for index in range(0, enemies.size()):
			var distanceToEnemy = enemies[index].global_position.distance_to(fromPosition)
			if distanceToEnemy < closestDistance:
				closestDistance = distanceToEnemy
				closestEnemy = enemies[index]
		return closestEnemy
	return null


func GetWorkerGroup():
	return get_tree().get_nodes_in_group("WorkerGroup")[0]
	
func GetClosestWorker(fromPosition):
	var worker = GetWorkerGroup().get_children()
	if worker.size() > 0:
		var closestWorker = worker[0]
		var closestDistance = 9999999999999999999
		for index in range(0, worker.size()):
			var distanceToEnemy = worker[index].global_position.distance_to(fromPosition)
			if distanceToEnemy < closestDistance:
				closestDistance = distanceToEnemy
				closestWorker = worker[index]
		return closestWorker
	return null
