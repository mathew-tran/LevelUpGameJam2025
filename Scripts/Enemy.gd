extends Area2D

class_name Enemy

var Direction = Vector2.ZERO
@export var Speed = 30
@export var Damage = 4

func _ready() -> void:
	$HealthComponent.OnDeath.connect(OnDeath)
	$HealthComponent.OnTakeDamage.connect(OnTakeDamage)
	
func OnTakeDamage(amount):
	$AnimationPlayer.stop()
	$AnimationPlayer.play("hit")
	
func OnDeath():
	queue_free()
	
func _process(delta: float) -> void:
	global_position += Direction * Speed * delta
	
func _on_area_entered(area: Area2D) -> void:
	if area is BaseProjectile:
		area.Direction =Vector2.ZERO
		$HealthComponent.TakeDamage(area.Damage)
		area.queue_free()

func ChangeDirection():
	var closeWorker = Finder.GetClosestWorker(global_position)
	if closeWorker:
		Direction = (closeWorker.global_position - global_position).normalized()
	
func _on_timer_timeout() -> void:
	ChangeDirection()
