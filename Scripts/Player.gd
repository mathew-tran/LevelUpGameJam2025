extends Node2D

class_name Player

var Headbody = null
var CameraMoveSpeed = 100
var LastKnownPosition = Vector2.ZERO


func _ready() -> void:
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

func _process(delta: float) -> void:
	if is_instance_valid(Headbody):
		var distance = Headbody.global_position.distance_to($Camera2D.global_position)
		if distance > 50:
			$Camera2D.global_position += (Headbody.global_position - $Camera2D.global_position).normalized() * CameraMoveSpeed * delta


func _on_player_position_timer_timeout() -> void:
	if Headbody:
		LastKnownPosition = Headbody.global_position
