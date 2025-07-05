extends Node2D

var Headbody = null
var CameraMoveSpeed = 100

func _ready() -> void:
	UpdateBody()
	
func UpdateBody():
	await get_tree().create_timer(.1).timeout
	var workers = $Workers.get_children()
	for index in range(0, workers.size()):
		if index == 0:
			workers[index].FollowObject = null
			Headbody = workers[index]
		else:
			workers[index].FollowObject = workers[index-1]


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
