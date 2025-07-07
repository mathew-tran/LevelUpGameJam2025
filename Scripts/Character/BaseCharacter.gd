extends RigidBody2D

class_name BaseCharacter

@export var CharacterDataRef : CharacterData

signal OnCharacterDeath
var Speed = 1
var FollowObject = null

var Velocity = Vector2.ZERO
var Damage = 10
var SubStatAttackRate : Resource

var SubStatDamage : Resource

var CharacterLevel = 1
var Penetration = 0
var Bounces = 0

var BaseHealthValue = 10

var RegenSpeed = 1
var RegenAmount = .25
			
var Spread = 1
var ProjectileSpeed = 5

var bCanBeHit = true



var BulletSpread : CharacterData.BULLET_SPREAD
var ShootType : CharacterData.SHOOT_TYPE

func GetNextUpgrade():
	if CharacterLevel > CharacterDataRef.Upgrades.size():
		return null
	return CharacterDataRef.Upgrades[CharacterLevel - 1]
	
func GetNextWeakUpgrade():
	return CharacterDataRef.WeakUpgrades.pick_random()
	
func AdjustHealth():
	$HealthComponent.MaxHealth = BaseHealthValue * Finder.GetGame().SubStatTeamHealth.Get().GetValue()
	print($HealthComponent.MaxHealth)
	OnTakeDamage(0)
	
func _ready() -> void:
	$RegenTimer.wait_time = 1 / RegenSpeed
	$RegenTimer.start()
	AdjustHealth()
	$HealthComponent.OnTakeDamage.connect(OnTakeDamage)
	$HealthComponent.OnDeath.connect(OnDeath)
	OnTakeDamage(0)
	Setup(CharacterDataRef)
	Finder.GetEXPBar().OnLevelUp.connect(OnLevelup)
	GiveTempInvincibility(2)
	
func OnLevelup():
	GiveTempInvincibility(.5)
	
func GiveTempInvincibility(amount = .3):
	if bCanBeHit == false:
		return
	bCanBeHit = false
	var tween = get_tree().create_tween()
	$HealthComponent.Disable()
	tween.tween_property($Sprite2D, "modulate", Color.YELLOW, .1)
	await tween.finished
	await get_tree().create_timer(amount).timeout
	tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", Color.WHITE, .1)
	await tween.finished
	$HealthComponent.Enable()
	bCanBeHit = true
	
func OnTakeDamage(_amount):
	$Healthbar.value = float($HealthComponent.CurrentHealth) / float($HealthComponent.MaxHealth)
	if _amount > 0:
		Jukebox.PlayerHurtSFX()
		
func OnDeath():
	OnCharacterDeath.emit()
	Jukebox.PlaySFX(load("res://Audio/SFX/levelup25-remove.wav"))
	queue_free()

func Setup(newData):
	CharacterDataRef = newData
	$Sprite2D.texture = CharacterDataRef.Picture
	Damage = CharacterDataRef.Damage
	ProjectileSpeed = CharacterDataRef.ProjectileSpeed
	Penetration = CharacterDataRef.Penetration
	Speed = Finder.GetGame().SubStateTeamSpeed.Get().GetValue()
	BulletSpread = CharacterDataRef.BulletSpread
	ShootType = CharacterDataRef.ShootType
	
	SubStatDamage = SubStatResourceData.new()
	SubStatDamage.StatResourceRef = load("res://Content/Stats/CHAR_DAMAGE.tres")
	SubStatDamage.FlatValue = Damage
	SubStatDamage.Init()
	
	SubStatAttackRate = SubStatResourceData.new()
	SubStatAttackRate.StatResourceRef = load("res://Content/Stats/CHAR_ATTACK_RATE.tres")
	SubStatAttackRate.FlatValue = CharacterDataRef.AttackSpeed

	SubStatAttackRate.Init()
	SubStatAttackRate.ModifiedResource.ValueUpdated.connect(OnAttackRateUpdate)
	Spread = CharacterDataRef.Spread
	$ShootTimer.wait_time = 1/SubStatAttackRate.Get().GetValue()
	
func OnAttackRateUpdate(rate):
	$ShootTimer.wait_time = 1/rate
	
func GetBulletAngles(amount):
	match BulletSpread:
		CharacterData.BULLET_SPREAD.NORMAL:
			var value = amount
			if value <= 1:
				return [0]
				
			var totalSpreadAngle = PI / 8
			
			var bulletAngle = totalSpreadAngle / (value - 1)
			var startAngle = -totalSpreadAngle / 2
			
			var rotations = []
			for i in range(value):
				rotations.append(rad_to_deg(startAngle + i * bulletAngle))
			return rotations
		CharacterData.BULLET_SPREAD.RADIAL:
			var increment = TAU / amount
			var rotations = []
			for x in range(0, amount):
				rotations.append(rad_to_deg(x * increment))
			return rotations
			
func _on_shoot_timer_timeout() -> void:
	if CharacterDataRef.Projectile:
		var delay = -1.0
		var amountOfTimesToShoot = 1
		if ShootType == CharacterData.SHOOT_TYPE.DOUBLE_SHOT:
			amountOfTimesToShoot += 1
			delay = .1
		if ShootType == CharacterData.SHOOT_TYPE.TRIPLE_SHOT:
			amountOfTimesToShoot += 2
			delay = .12
		
		for shootAmount in range(0, amountOfTimesToShoot):
			var enemy = Finder.GetClosestEnemy(global_position)
			if enemy:
				for angle in GetBulletAngles(Spread):
					var instance = CharacterDataRef.Projectile.instantiate()
					instance.Direction = (enemy.global_position - global_position).normalized()
					instance.Speed = ProjectileSpeed
					var radians = float(deg_to_rad(angle))
					instance.Direction = instance.Direction.rotated(radians)
					instance.global_position = global_position
					instance.Damage = SubStatDamage.Get().GetValue() + randi_range(0, 4)
					instance.Penetration = Penetration
					instance.Bounces += Bounces
					Finder.GetBulletsGroup().add_child(instance)
			if delay > 0:
				$ShootTimer.stop()
				await get_tree().create_timer(delay).timeout
				
		$ShootTimer.start()
		

func _process(delta: float) -> void:
	if $HitTimer.time_left == 0.0:
		var areas = $Hitbox.get_overlapping_bodies()
		for area in areas:
			if area is Enemy:
				$HealthComponent.TakeDamage(area.Damage)
				$HitTimer.start()	
	var followObjectPosition = get_global_mouse_position()
	if FollowObject:
		followObjectPosition = FollowObject.global_position
		

	
	if global_position.distance_to(followObjectPosition) > 50:
		Velocity = Vector2.ZERO
		var dir = (followObjectPosition - global_position).normalized()
		Velocity += dir * Speed * delta
		$Sprite2D.flip_h = Velocity.x <= 0
	else:
		pass
	
	move_and_collide(Velocity)
	

func Activate():
	$ActiveCircle.visible = true

func Deactivate():
	$ActiveCircle.visible = false

func _on_regen_timer_timeout() -> void:
	$HealthComponent.Heal(RegenAmount)
