extends Node2D

class_name Game

signal OnEXPUpdate(amount)
signal OnGameOver
signal OnRemoveCharFromGame(char)
signal OnMoneyUpdate(amount)
signal OnRoundUpdate(roundNumber, bIsBoss)
var SubStatTeamHealth : Resource
var SubStateTeamSpeed : Resource

var Money = 10

func _enter_tree() -> void:
	Setup()
func _ready() -> void:
	Jukebox.PlayMusic(JukeboxPlayer.MUSIC_TYPE.FIGHT)
	

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
	
func OnTeamHealthUpdated(value):
	var workers = Finder.GetWorkerGroup()
	for worker in workers.get_children():
		worker.AdjustHealth()
	
func OnTeamSpeedUpdated(value):
	var workers = Finder.GetWorkerGroup()
	for worker in workers.get_children():
		worker.Speed = value
		print(worker.Speed)
	
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
