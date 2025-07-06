extends Node2D

var XPLimit = 50
var MoneyLimit = 10

var PlayerPosition = Vector2.ZERO
var Distance = 500
func _on_timer_timeout() -> void:
	PlayerPosition = Finder.GetPlayer().LastKnownPosition
	CleanXP()
	CleanMoney()
	

func CleanXP():
	var pickups = Finder.GetPickupGroup()
	var EXPAmount = 0
	var XPOrbs = []
	var firstPosition = Vector2.ZERO
	for pickup in pickups.get_children():
		if is_instance_valid(pickup):
			if pickup is EXPPickup:
				if pickup.bMoveTowardsPlayer:
					pass
				elif pickup.Amount > 200:
					pass
				elif pickup.global_position.distance_to(PlayerPosition) > Distance:
					if firstPosition == Vector2.ZERO:
						firstPosition = pickup.global_position
					XPOrbs.append(pickup)
					

	if XPOrbs.size() >= XPLimit:
		print("Cleaning " + str(XPOrbs.size()) + " XP orbs")
		for xp in XPOrbs:
			EXPAmount += xp.Amount
			xp.queue_free()
		var instance = load("res://Prefabs/Pickups/EXP.tscn").instantiate()
		instance.Amount = EXPAmount
		instance.global_position = firstPosition
		Finder.GetPickupGroup().add_child(instance)
					
func CleanMoney():
	var pickups = Finder.GetPickupGroup()
	var MoneyAmount = 0
	var Money = []
	var firstPosition = Vector2.ZERO
	for pickup in pickups.get_children():
		if is_instance_valid(pickup):
			if pickup is MoneyPickup:

				if pickup.Amount > 10:
					pass
				elif pickup.global_position.distance_to(PlayerPosition) > Distance:
					if firstPosition == Vector2.ZERO:
						firstPosition = pickup.global_position
					Money.append(pickup)
					

	if Money.size() >= MoneyLimit:
		print("Cleaning " + str(Money.size()) + " Money orbs")
		for pickup in Money:
			MoneyAmount += pickup.Amount
			pickup.queue_free()
		var instance = load("res://Prefabs/Pickups/Money.tscn").instantiate()
		instance.Amount = MoneyAmount
		instance.global_position = firstPosition
		Finder.GetPickupGroup().add_child(instance)
