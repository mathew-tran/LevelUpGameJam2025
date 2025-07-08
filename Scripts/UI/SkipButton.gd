extends Button


func _on_button_up() -> void:
	Finder.GetGame().AddMoney(1)
	Finder.GetLevelUp().Close()
	Jukebox.PlaySFXMenu(load("res://Audio/SFX/MenuSelect.wav"))


func _on_mouse_entered() -> void:
	Jukebox.PlaySFXMenu(load("res://Audio/SFX/Menuhover.wav"))
