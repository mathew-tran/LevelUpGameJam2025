extends RigidBody2D

class_name BaseCharacter

@export var CharacterDataRef : CharacterData

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

var ContactMultiplier = .4

var BulletSpread : CharacterData.BULLET_SPREAD
var ShootType : CharacterData.SHOOT_TYPE

var bDoubleDamage = false

var StunChance = 0

func SayDeathPhrase():
	Speak(CharacterDataRef.DeathPhrase.pick_random())
	
func GetNextUpgrade():
	if CharacterLevel > CharacterDataRef.Upgrades.size():
		return null
	return CharacterDataRef.Upgrades[CharacterLevel - 1]
	
func GetNextWeakUpgrade():
	return CharacterDataRef.WeakUpgrades.pick_random()
	
func AdjustHealth():
	$HealthComponent.MaxHealth = BaseHealthValue * Finder.GetGame().SubStatTeamHealth.Get().GetValue()
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
	GiveTempInvincibility(2)
	
func GiveTempInvincibility(amount = .3):
	if bCanBeHit == false:
		return
	bCanBeHit = false
	var tween = get_tree().create_tween()
	$HealthComponent.Disable()
	tween.tween_property($Sprite2D, "modulate", Color(1.3,1.3,1.3,.6), .1)
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
	
	if Finder.GetGame().bShootOnHurt:
		if _amount > 0:
			if Helper.Roll(10, 100):
				_on_shoot_timer_timeout()
				Speak("!!!")
				
	if Finder.GetGame().bInvulnerabilityChance:
		if _amount > 0:
			if Helper.Roll(10, 100):
				Speak("!!!")
				GiveTempInvincibility(.5)
				
	if Finder.GetGame().bGainExperienceOnHit:
		if _amount > 0:
			Helper.DropEXPOrb(10, global_position)
			
func Heal(amount):
	$HealthComponent.Heal(amount)
	
func OnDeath():
	Finder.GetGame().AddCharacterToGame(CharacterDataRef.resource_path)
	
	if Finder.GetGame().bExplodeOnDeath:
		_on_shoot_timer_timeout()
		_on_shoot_timer_timeout()
		_on_shoot_timer_timeout()
		
	var damageClass = load("res://Prefabs/UI/DamageText.tscn")
	var instance = damageClass.instantiate()
	instance.global_position = global_position
	var data = {}
	data["text"] = CharacterDataRef.Name.to_upper() + "\nHAS RESIGNED"
	data["color"] = Color.WHITE
	data["position"] = Vector2.ZERO
	data["time"] = 3
	instance.data = data
	Finder.GetEffectGroup().add_child(instance)
	
	var expAmount = (CharacterLevel + 1) * 50
	var increments = 360 / (CharacterLevel + 6)
	for x in range(0, CharacterLevel + 6):
		var spawnPosition = Helper.GetPositionAroundPoint(global_position, 400, increments * x)
		Helper.DropEXPOrbMoveFromXtoY(expAmount, global_position, spawnPosition, .4)
	Jukebox.PlayPlayerDeathSFX()

	queue_free()

func Speak(message):
	var data = {}
	data["message"] = message
	data["pitch"] = CharacterDataRef.Pitch
	data["audio"] = CharacterDataRef.Voice
	$TalkBubble.Talk(data)
	
func Setup(newData):
	CharacterDataRef = newData
	$Sprite2D.texture = CharacterDataRef.Picture
	Damage = CharacterDataRef.Damage
	ProjectileSpeed = CharacterDataRef.ProjectileSpeed
	Penetration = CharacterDataRef.Penetration
	Speed = Finder.GetGame().SubStateTeamSpeed.Get().GetValue()
	BulletSpread = CharacterDataRef.BulletSpread
	ShootType = CharacterDataRef.ShootType
	
	Speak(CharacterDataRef.WelcomePhrase)
	
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
	
	await get_tree().process_frame
	Finder.GetGame().RemoveCharacterFromGame(CharacterDataRef.Name)
	
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
					if is_instance_valid(SubStatDamage) == false:
						return
					var instance = CharacterDataRef.Projectile.instantiate()
					instance.Direction = (enemy.global_position - global_position).normalized()
					instance.Speed = ProjectileSpeed * Finder.GetGame().SubStatTeamProjectileSpeed.Get().GetValue()
					var radians = float(deg_to_rad(angle))
					instance.Direction = instance.Direction.rotated(radians)
					instance.global_position = global_position
					instance.Damage = Finder.GetGame().SubStatTeamDamage.Get().GetValue() * (SubStatDamage.Get().GetValue() + randi_range(0, 4))
					instance.Penetration = Penetration
					instance.Bounces += Bounces
					
					if Helper.Roll(StunChance, 100):
						instance.bStunEnemy = true
					if Finder.GetGame().bExtraBounce:
						if Bounces > 0:
							instance.Bounces += 1
							
					if Finder.GetGame().bBonusDamage:
						if Helper.Roll(10, 100):
							instance.Damage *= 1.5
					if bDoubleDamage:
						instance.Damage *= 2
					Finder.GetBulletsGroup().add_child(instance)
			if delay > 0:
				$ShootTimer.stop()
				await get_tree().create_timer(delay).timeout
				
		$ShootTimer.start()
		
func GetContactDamage():
	var dmg = Damage
	if Spread > 0:
		dmg *= Spread
	if Penetration > 0:
		dmg *= Penetration
	if Bounces > 0:
		dmg *= Bounces
	dmg *= ContactMultiplier * Finder.GetGame().SubStatTeamContactDamage.Get().GetValue()
	return dmg
	
func _process(delta: float) -> void:
	if $HitTimer.time_left == 0.0:
		var areas = $Hitbox.get_overlapping_bodies()
		for area in areas:
			var bTakeDamage = true
			if area is Enemy:
				if Finder.GetGame().bDodgeChance:
					if Helper.Roll(10, 100):
						bTakeDamage = false
						Speak("NICE TRY!")
				if bTakeDamage:
					$HealthComponent.TakeDamage(area.Damage)
				area.TakeDamage(GetContactDamage())
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

func GetBuffsHolder():
	return $Buffs
