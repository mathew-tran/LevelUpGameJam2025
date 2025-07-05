extends Area2D

class_name Enemy

var Direction = Vector2.ZERO
@export var Speed = 30
@export var Damage = 4
@export var EXPToDrop = 10

func _ready() -> void:
	$HealthComponent.OnDeath.connect(OnDeath)
	$HealthComponent.OnTakeDamage.connect(OnTakeDamage)
	
func OnTakeDamage(amount):
	$AnimationPlayer.stop()
	$AnimationPlayer.play("hit")
	var damageClass = load("res://Prefabs/UI/DamageText.tscn")
	var instance = damageClass.instantiate()
	instance.global_position = global_position
	var data = {}
	data["text"] = str(amount)
	data["color"] = Color.RED
	instance.data = data
	Finder.GetEffectGroup().add_child(instance)
	
func OnDeath():
	var instance = load("res://Prefabs/Pickups/EXP.tscn").instantiate()
	instance.global_position = global_position
	instance.Amount = EXPToDrop
	Finder.GetEffectGroup().add_child(instance)
	queue_free()
	
func _process(delta: float) -> void:
	global_position += Direction * Speed * delta
	$Sprite2D.flip_h = Direction.x <= 0
	
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
