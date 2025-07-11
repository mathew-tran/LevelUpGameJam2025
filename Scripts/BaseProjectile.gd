extends Area2D

class_name BaseProjectile

var Direction = Vector2.RIGHT
var Speed = 5
var Damage = 3
var Penetration = 0

var bStunEnemy = false
@export var Bounces = 0
@export var SubProjectile : PackedScene
@export var SubProjectileAmount = -1 

func _ready():
	rotation = Direction.angle()
	
func _process(delta: float) -> void:
	global_position += Direction * Speed

func Hit():
	
	if Bounces > 0 and $BounceTimer.time_left == 0.0:
		Bounces -= 1
		$BounceTimer.start()
		return
	if Penetration <= 0:
		Kill()
	else:
		Penetration -= 1
		if Finder.GetGame().bExtraPenetration:
			Damage *= 1.5
		
func _on_live_timer_timeout() -> void:
	Kill()

func Kill():
	if SubProjectileAmount > 0:
		if is_instance_valid(SubProjectile):
			for x in range(0, SubProjectileAmount):
				var instance = SubProjectile.instantiate()
				instance.global_position = Helper.GetRandomPositionAroundPoint(global_position, 10)
				instance.Damage = Damage / SubProjectileAmount
				Finder.GetSubBulletsGroup().call_deferred("add_child",instance)
	queue_free()
	
func _on_bounce_timer_timeout() -> void:
	var closestEnemy = Finder.GetClosestEnemy(global_position)
	if closestEnemy:
		Direction = (closestEnemy.global_position - global_position).normalized()
		rotation = Direction.angle()


func _on_area_entered(area: Area2D) -> void:
	if area is EXPPickup:
		if area.IsFollowing() == false:
			area.SetFollowing()
			Hit()
