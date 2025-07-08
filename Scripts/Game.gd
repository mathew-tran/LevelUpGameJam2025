extends Node2D

class_name Game

signal OnEXPUpdate(amount)
signal OnGameOver
signal OnRemoveCharFromGame(char)
signal OnMoneyUpdate(amount)
signal OnRoundUpdate(roundNumber, customText)
signal OnInvestDepartment(department)
signal OnPowerupGained(department, text)
var SubStatTeamHealth : Resource
var SubStateTeamSpeed : Resource
var SubStatTeamDamage : Resource
var SubStatTeamExperience : Resource

var Money = 10

var bCanDropMagnet = false
var bExplodeOnDeath = false


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
	
func GetMoney():
	return Money
	
func RemoveMoney(amount):
	Money -= amount
	OnMoneyUpdate.emit()
	
func AddEXP(amount):
	OnEXPUpdate.emit(amount)
	
func RemoveCharacterFromGame(char):
	OnRemoveCharFromGame.emit(char)
