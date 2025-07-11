extends Node2D

class_name Player

var Headbody = null
var CameraMoveSpeed = 200
var LastKnownPosition = Vector2.ZERO


func _ready() -> void:
	LastKnownPosition = Finder.GetSpawnPoints().GetRandomSpawnPoint()
	GameData.ChosenCharacter.Create()
	UpdateBody()
	
	


	
	
func UpdateBody():
	await get_tree().create_timer(.1).timeout
	var workers = $Workers.get_children()
	for index in range(0, workers.size()):
		if index == 0:
			workers[index].FollowObject = null
			Headbody = workers[index]
			workers[index].Activate()
		else:
			workers[index].FollowObject = workers[index-1]
			workers[index].Deactivate()
	if workers.size() == 0:
		Jukebox.PlayMusic(JukeboxPlayer.MUSIC_TYPE.DEAD)
		Finder.GetGame().OnGameOver.emit()

func GetPlayerPosition():
	return LastKnownPosition
	
func _on_workers_child_entered_tree(node: Node) -> void:
	print(node.name + "entered")
	UpdateBody()


func _on_workers_child_exiting_tree(node: Node) -> void:
	print(node.name + "exited")
	UpdateBody()
	await get_tree().create_timer(.1).timeout
	if $Workers.get_child_count() > 0:
		$AnimationPlayer.play("death")
		Finder.GetGame().Slomo(.2, 1)
		var workers = $Workers.get_children()
		for worker in workers:
			worker.GiveTempInvincibility(.5)
			worker.SayDeathPhrase()
	
	

func _process(delta: float) -> void:
	if Headbody:
		$Position.global_position = Headbody.global_position

func _on_player_position_timer_timeout() -> void:
	if Headbody:
		LastKnownPosition = Headbody.global_position
