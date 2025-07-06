extends Area2D

@export var Amount = 5

func Pickup():
	Finder.GetGame().AddEXP(Amount)
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is BaseCharacter:
		Pickup()
		
