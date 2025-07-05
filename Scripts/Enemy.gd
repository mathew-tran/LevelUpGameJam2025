extends Area2D

func _ready() -> void:
	$HealthComponent.OnDeath.connect(OnDeath)
	$HealthComponent.OnTakeDamage.connect(OnTakeDamage)
	
func OnTakeDamage(amount):
	$AnimationPlayer.stop()
	$AnimationPlayer.play("hit")
	
func OnDeath():
	queue_free()
	
func _on_area_entered(area: Area2D) -> void:
	if area is BaseProjectile:
		area.Direction =Vector2.ZERO
		$HealthComponent.TakeDamage(area.Damage)
		area.queue_free()
