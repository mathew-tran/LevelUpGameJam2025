extends Area2D


class_name Pickup

var bMoveTowardsPlayer  = false
var bIsUsable = true
var bTransitioning = false
func _enter_tree() -> void:
	scale = Vector2.ZERO
	
func Setup():
	pass
	
func _ready() -> void:	
	Setup()
	_on_poll_timer_timeout()
	
func IsFollowing():
	return bMoveTowardsPlayer
	
func SetFollowing():
	if bTransitioning:
		return
	bTransitioning = true
	bIsUsable = false
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", global_position + Vector2(0, -30), .2)
	await tween.finished
	bMoveTowardsPlayer = true
	bIsUsable = true
	
func DoPickupAction():
	pass
	
func Pickup():
	bIsUsable = false
	DoPickupAction()
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is BaseCharacter:
		if bIsUsable == false:
			return
		Pickup()
		
		
func _process(delta: float) -> void:
	if bMoveTowardsPlayer:
		var dir = (Finder.GetPlayer().LastKnownPosition - global_position).normalized()
		if Finder.GetPlayer().LastKnownPosition.distance_to(global_position) < 32:
			Pickup()
		global_position += dir * 500 * delta
		rotation_degrees += delta * 100
		


func _on_timer_timeout() -> void:
	queue_free()


func _on_poll_timer_timeout() -> void:
	modulate.a = ($Timer.time_left / $Timer.wait_time)
