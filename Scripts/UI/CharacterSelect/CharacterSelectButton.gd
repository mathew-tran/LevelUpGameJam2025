extends Button

signal OnClicked(charData)

@export var CharRefData : CharacterData

func Setup(chardata):
	CharRefData = chardata
	$TextureRect.texture = CharRefData.Picture
	$Panel.visible = false
	

func _on_button_up() -> void:
	OnClicked.emit(CharRefData)

func SetEnabled(bEnabled):
	$Panel.visible = bEnabled


func _on_mouse_entered() -> void:
	Jukebox.PlaySFXMenu(load("res://Audio/SFX/Menuhover.wav"))
