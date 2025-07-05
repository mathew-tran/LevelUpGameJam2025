extends RigidBody2D

@export var CharacterDataRef : CharacterData

var Speed = 100
@export var bIsHead = true

var Velocity = Vector2.ZERO
			
func _ready() -> void:
	$HealthComponent.OnTakeDamage.connect(OnTakeDamage)
	$HealthComponent.OnDeath.connect(OnDeath)
	OnTakeDamage(0)
	
func OnTakeDamage(_amount):
	$Healthbar.value = float($HealthComponent.CurrentHealth) / float($HealthComponent.MaxHealth)

func OnDeath():
	get_tree().reload_current_scene()

func Setup():
	$Sprite2D.texture = CharacterDataRef.Picture

func _on_shoot_timer_timeout() -> void:
	if CharacterDataRef.Projectile:
		var enemy = Finder.GetClosestEnemy(global_position)
		if enemy:
			var instance = CharacterDataRef.Projectile.instantiate()
			instance.Direction = (enemy.global_position - global_position).normalized()
			instance.global_position = global_position
			Finder.GetBulletsGroup().add_child(instance)

func _process(delta: float) -> void:
	if $HitTimer.time_left == 0.0:
		var areas = $Hitbox.get_overlapping_areas()
		for area in areas:
			if area is Enemy:
				$HealthComponent.TakeDamage(area.Damage)
				$HitTimer.start()
	if bIsHead:
		
		if global_position.distance_to(get_global_mouse_position()) > 50:
			var dir = (get_global_mouse_position() - global_position).normalized()
			Velocity = Vector2.ZERO
			Velocity += dir * Speed * delta
		else:
			Velocity = Vector2.ZERO
		move_and_collide(Velocity)
