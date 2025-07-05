extends Node2D

class_name Game

signal OnEXPUpdate(amount)
signal OnGameOver

func _ready() -> void:
	Jukebox.PlayMusic(JukeboxPlayer.MUSIC_TYPE.NONE)

func AddEXP(amount):
	OnEXPUpdate.emit(amount)
	
