extends Node2D

@onready var container = $GridContainer

func _ready() -> void:
	$AudioStreamPlayer.play()
	Jukebox.PlayMusic(JukeboxPlayer.MUSIC_TYPE.NONE)
	Populate()
	$CanvasLayer/StatsPanel.Update()

func _on_button_button_up() -> void:
	get_tree().change_scene_to_packed(load("res://Prefabs/UI/CharacterSelect/CharacterSelectScreen.tscn"))

func Populate():
	container.visible = false
	for child in container.get_children():
		child.queue_free()
	
	await get_tree().process_frame
	
	var pipClass = load("res://Prefabs/UI/CharacterPipEnding.tscn")
	for character in GameData.CharactersYouWonWith:
		var instance = pipClass.instantiate()
		instance.Setup(character)
		container.add_child(instance)
	container.visible = true
