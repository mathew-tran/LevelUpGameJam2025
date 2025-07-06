extends Button


func _on_button_up() -> void:
	Finder.GetGame().AddMoney(1)
	Finder.GetLevelUp().Close()
