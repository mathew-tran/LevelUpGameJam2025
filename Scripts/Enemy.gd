extends RigidBody2D

class_name Enemy

var Direction = Vector2.ZERO
@export var Speed = 30
@export var Damage = 4
@export var Penetration = 0
@export var EXPToDrop = 10
var Velocity=  Vector2.ZERO
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
	data["text"] = (str(int(amount)))
	data["color"] = Color.WHITE
	instance.data = data
	Finder.GetEffectGroup().add_child(instance)
	Jukebox.PlaySFX(load("res://Audio/SFX/hit.wav"))
	
func OnDeath():
	var instance = load("res://Prefabs/Pickups/EXP.tscn").instantiate()
	instance.global_position = global_position
	instance.Amount = EXPToDrop
	Finder.GetEffectGroup().call_deferred("add_child", instance)
	queue_free()
	
func _process(delta: float) -> void:
	Velocity = Vector2.ZERO
	Velocity += Direction * Speed * delta
	$Sprite2D.flip_h = Direction.x <= 0
	if test_move(transform, Velocity) == false:
		move_and_collide(Velocity)
	

func ChangeDirection():
	var closeWorker = Finder.GetClosestWorker(global_position)
	if closeWorker:
		Direction = (closeWorker.global_position - global_position).normalized()
	
func _on_timer_timeout() -> void:
	ChangeDirection()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is BaseProjectile:
		$HealthComponent.TakeDamage(area.Damage)
		area.Hit()
