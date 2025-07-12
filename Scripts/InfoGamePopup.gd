extends CanvasLayer

@onready var Desc = $Popup/VBoxContainer/Label2
@onready var Img = $Popup/VBoxContainer/TextureRect

func _ready() -> void:
	visible = false
	
func _on_button_button_up() -> void:
	visible = false

func ShowPopup(data):
	Desc.text = ""
	Img.texture = null
	if data.has("message"):
		Desc.text = data["message"]
	if data.has("img"):
		Img.texture = data["img"]
	visible = true
