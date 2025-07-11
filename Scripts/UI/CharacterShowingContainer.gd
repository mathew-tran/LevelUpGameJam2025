extends GridContainer

func _ready() -> void:
	Finder.GetLevelUp().OnLevelUpMenuOpened.connect(OnLevelUpMenuOpened)
	
func OnLevelUpMenuOpened():
	visible = false
	var characterClass = load("res://Prefabs/UI/CharacterPip.tscn")
	for child in get_children():
		child.queue_free()
		
	await get_tree().process_frame
	
	for character in Finder.GetWorkerGroup().get_children():
		var instance = characterClass.instantiate()
		instance.Setup(character)
		add_child(instance)
	visible = true
	
	
