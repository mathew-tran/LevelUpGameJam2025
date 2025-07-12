extends Panel


func _on_visibility_changed() -> void:
	var text = ""
	var keys = GameData.Data.keys()
	keys.sort()
	for data in keys:
		text += data + ":    " + str(int(GameData.Data[data])) + "\n"
	$VBoxContainer/ScrollContainer/VBoxContainer2/Label.text = text

func Update():
	_on_visibility_changed()
