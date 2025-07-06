extends Area2D

@export var Amount = 1


func _on_body_entered(body: Node2D) -> void:
	Finder.GetGame().AddMoney(Amount)
	queue_free()
