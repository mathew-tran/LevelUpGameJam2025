extends Node2D

class_name Game

signal OnEXPUpdate(amount)
signal OnGameOver
signal OnRemoveCharFromGame(char)
signal OnAddCharToGame(resourcePath)
signal OnMoneyUpdate(amount)
signal OnRoundUpdate(roundNumber, customText)
signal OnInvestDepartment(department)
signal OnPowerupGained(department, text)
signal OnEnemiesKilled()
var SubStatTeamHealth : Resource
var SubStateTeamSpeed : Resource
var SubStatTeamDamage : Resource
var SubStatTeamExperience : Resource
var SubStatTeamContactDamage : Resource
var SubStatTeamProjectileSpeed : Resource
var SubStatPickupRadius : Resource

var SubStatEnemyHealthMultiplier : Resource


var Money = 0
var EnemiesKilled = 0

var bCanDropMagnet = false
var bExplodeOnDeath = false
var bShootOnHurt = false

var bHealOnLevelup = false
var bExtraBounce = false
var bExtraPenetration = false
var bBonusDamage = false
var bInvulnerabilityChance = false
var bDodgeChance = false
var bStunChance = false
var bGainExperienceOnHit = false
var bGainHealthWhenMoneyPickedUp = false

var bBerserkModeActive = false
var bInvincibleModeActive = false
var bDoubleDamageModeActive = false
var bStunModeActive = false
var bStunExtraDamage = true

var bExtraMoneyDrop = false
var bExtraMoneyOnSkip = false

enum GAME_STATE {
	PlAYING,
	LEVELUP,
	FINISHED
}

var CurrentState = GAME_STATE.PlAYING

func SetGameState(state : GAME_STATE):
	CurrentState = state
	
func IsInGame():
	return CurrentState == GAME_STATE.PlAYING
	
func IsLevellingUp():
	return CurrentState == GAME_STATE.LEVELUP

func IsGameFinished():
	return CurrentState == GAME_STATE.FINISHED
	
func BroadcastEnemyKilled():
	EnemiesKilled += 1
	OnEnemiesKilled.emit()
	
func SetTimer(amount):
	$RoundTimer.wait_time = amount
	$RoundTimer.start()
	
func IsTimerDone():
	return $RoundTimer.time_left == 0.0
	
func GetTimerProgress():
	return $RoundTimer.wait_time / $RoundTimer.time_left
	
func _enter_tree() -> void:
	Setup()
	
func _ready() -> void:
	Jukebox.PlayMusic(JukeboxPlayer.MUSIC_TYPE.FIGHT)
	Slomo(1,.001)
	get_tree().paused = false
	SetGameState(GAME_STATE.PlAYING)
	GameData.Data.clear()
	AddMoney(10)
	

func Setup():
	SubStatTeamHealth = SubStatResourceData.new()
	SubStatTeamHealth.StatResourceRef = load("res://Content/Stats/CHAR_DAMAGE.tres")
	SubStatTeamHealth.FlatValue = 1
	SubStatTeamHealth.Init()
	SubStatTeamHealth.ModifiedResource.ValueUpdated.connect(OnTeamHealthUpdated)
	
	
	SubStateTeamSpeed = SubStatResourceData.new()
	SubStateTeamSpeed.StatResourceRef = load("res://Content/Stats/TEAM_SPEED.tres")
	SubStateTeamSpeed.Init()
	SubStateTeamSpeed.ModifiedResource.ValueUpdated.connect(OnTeamSpeedUpdated)
	
	SubStatTeamDamage = SubStatResourceData.new()
	SubStatTeamDamage.StatResourceRef = load("res://Content/Stats/TEAM_DAMAGE.tres")
	SubStatTeamDamage.Init()
	
	SubStatTeamExperience = SubStatResourceData.new()
	SubStatTeamExperience.StatResourceRef = load("res://Content/Stats/TEAM_EXPERIENCE.tres")
	SubStatTeamExperience.Init()
	
	SubStatTeamContactDamage = SubStatResourceData.new()
	SubStatTeamContactDamage.StatResourceRef = load("res://Content/Stats/TEAM_CONTACT_DAMAGE.tres")
	SubStatTeamContactDamage.Init()
	
	SubStatTeamProjectileSpeed = SubStatResourceData.new()
	SubStatTeamProjectileSpeed.StatResourceRef = load("res://Content/Stats/TEAM_PROJECTILE_SPEED.tres")
	SubStatTeamProjectileSpeed.Init()
	
	SubStatPickupRadius = SubStatResourceData.new()
	SubStatPickupRadius.StatResourceRef = load("res://Content/Stats/TEAM_PICKUP_RADIUS.tres")
	SubStatPickupRadius.Init()
	SubStatTeamHealth.ModifiedResource.ValueUpdated.connect(OnPickupRadiusUpdated)
	
	SubStatEnemyHealthMultiplier = SubStatResourceData.new()
	SubStatEnemyHealthMultiplier.StatResourceRef = load("res://Content/Stats/ENEMY_HEALTH_MULTIPLIER.tres")
	SubStatEnemyHealthMultiplier.Init()
	match GameData.Difficulty:
		GameData.DIFFICULTY.EASY:
			SubStatEnemyHealthMultiplier.ModifiedResource.FlatValue = .75
		GameData.DIFFICULTY.MEDIUM:
			SubStatEnemyHealthMultiplier.ModifiedResource.FlatValue = 1.00
		GameData.DIFFICULTY.HARD:
			SubStatEnemyHealthMultiplier.ModifiedResource.FlatValue = 1.25
	
	print(SubStatEnemyHealthMultiplier.Get().GetValue())
func OnPickupRadiusUpdated(value):
	var workers = Finder.GetWorkerGroup()
	for worker in workers.get_children():
		worker.UpdatePickupRadius()
			
func OnTeamHealthUpdated(value):
	var workers = Finder.GetWorkerGroup()
	for worker in workers.get_children():
		worker.AdjustHealth()
	
func OnTeamSpeedUpdated(value):
	var workers = Finder.GetWorkerGroup()
	for worker in workers.get_children():
		worker.Speed = value
		print(worker.Speed)
	
func Slomo(amount, time):
	Engine.time_scale = amount
	await get_tree().create_timer(time).timeout
	Engine.time_scale = 1
	
func AddMoney(amount):
	Money += amount
	OnMoneyUpdate.emit()
	GameData.AddData("Money Gained", amount)
	
func GetMoney():
	return Money
	
func RemoveMoney(amount):
	Money -= amount
	GameData.AddData("Money Spent", amount)
	OnMoneyUpdate.emit()
	
func AddEXP(amount):
	OnEXPUpdate.emit(amount)
	
func RemoveCharacterFromGame(char):
	OnRemoveCharFromGame.emit(char)

func AddCharacterToGame(resPath):
	OnAddCharToGame.emit(resPath)
