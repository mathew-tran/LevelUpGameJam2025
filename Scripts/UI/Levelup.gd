extends Panel

@onready var PurchaseContainer = $Panel/HBoxContainer

func _ready() -> void:
	Finder.GetEXPBar().OnLevelUp.connect(OnLevelup)
	
func OnLevelup():
	Setup()
	
func Setup():
	get_tree().paused = true
	await Cleanup()
	var instance = load("res://Prefabs/UI/PurchaseButton.tscn").instantiate()
	PurchaseContainer.add_child(instance)
	instance.OnPurchased.connect(OnPurchased)
	visible = true
	
func Cleanup():
	for child in PurchaseContainer.get_children():
		child.queue_free()
	await get_tree().create_timer(.1).timeout
	
func OnPurchased():
	Close()
	
func Close():
	visible = false
	Cleanup()
	get_tree().paused = false
