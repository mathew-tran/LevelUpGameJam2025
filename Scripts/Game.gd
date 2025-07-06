extends Node2D

class_name Game

signal OnEXPUpdate(amount)
signal OnGameOver

var SubStatTeamHealth : Resource

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
	
func OnTeamHealthUpdated(value):
	var workers = Finder.GetWorkerGroup()
	for worker in workers.get_children():
		worker.AdjustHealth()
	
	
func AddEXP(amount):
	OnEXPUpdate.emit(amount)
	
