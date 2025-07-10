extends RigidBody2D

class_name Enemy

var Direction = Vector2.ZERO
@export var Speed = 30
@export var Damage = 4
@export var Penetration = 0
@export var EXPToDrop = 10
@export var MoneyDropChance = 2.0

var bIsStunned = false

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
	
	if Finder.GetGame().bStunChance:
		var result = randi() % 100
		if result <= 5:
			bIsStunned = true
			$StunTimer.start()
			modulate = Color.SKY_BLUE
	
func OnDeath():
	Helper.DropEXPOrb(EXPToDrop, global_position)
	var result = randi() % 100
	if result <= MoneyDropChance:
		var moneyInstance = load("res://Prefabs/Pickups/Money.tscn").instantiate()
		moneyInstance.global_position = Helper.GetRandomPositionAroundPoint(global_position,100)
		Finder.GetPickupGroup().call_deferred("add_child", moneyInstance)
		
	if Finder.GetGame().bCanDropMagnet:
		result = randi() % 200
		if result <= 1:
			var moneyInstance = load("res://Prefabs/Pickups/Magnet.tscn").instantiate()
			moneyInstance.global_position = Helper.GetRandomPositionAroundPoint(global_position,100)
			Finder.GetPickupGroup().call_deferred("add_child", moneyInstance)
	Jukebox.PlayEnemyDeathSFX()
	Finder.GetGame().BroadcastEnemyKilled()
	queue_free()
	
func _process(delta: float) -> void:
	if bIsStunned:
		return
		
	Velocity = Vector2.ZERO
	Velocity += Direction * Speed * delta
	$Sprite2D.flip_h = Direction.x <= 0
	move_and_collide(Velocity)
	

func ChangeDirection():
	var closeWorker = Finder.GetClosestWorker(global_position)
	if closeWorker:
		Direction = (closeWorker.global_position - global_position).normalized()
	
func _on_timer_timeout() -> void:
	ChangeDirection()

func TakeDamage(amount):
	$HealthComponent.TakeDamage(amount)
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is BaseProjectile:
		TakeDamage(area.Damage)
		area.Hit()


func _on_stun_timer_timeout() -> void:
	bIsStunned = false
	modulate = Color.WHITE
