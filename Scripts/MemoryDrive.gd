extends Sprite2D

@export var Amount = 500

func _ready() -> void:
	$AnimationPlayer.play("anim")
	
func DestroyMemory():
	var pieces = 30
	var expAmount =  Finder.GetEXPBar().MaxEXP * 3 / pieces
	var increments = 360 / pieces
	for x in range(0, pieces):
		var spawnPosition = Helper.GetPositionAroundPoint(global_position, 100, increments * x)
		Helper.DropEXPOrbMoveFromXtoY(expAmount, global_position, spawnPosition, .4)
	queue_free()
