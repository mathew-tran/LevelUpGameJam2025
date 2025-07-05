extends Button

signal OnPurchased

func _on_button_up() -> void:
	OnPurchased.emit()
