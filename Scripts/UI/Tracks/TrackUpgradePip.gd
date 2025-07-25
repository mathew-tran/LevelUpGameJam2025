extends TextureRect

var UpgradeTrackRef : TrackUpgradeData

var bActivated = false

func Setup(trackRef, themeColor):
	self_modulate = themeColor
	UpgradeTrackRef = trackRef
	if UpgradeTrackRef:
		texture = load("res://Art/UI/TickOffBig.png")
	else:
		texture = load("res://Art/UI/TickOff.png")
	
func Activate():
	if UpgradeTrackRef:
		texture = load("res://Art/UI/TickOnBig.png")
		UpgradeTrackRef.ApplyUpgrade()
		Finder.GetGame().OnPowerupGained.emit(get_parent().get_parent().Category, UpgradeTrackRef.GetUpgradeName())
	else:
		texture = load("res://Art/UI/TickOn.png")
		


func _on_mouse_entered() -> void:
	if UpgradeTrackRef:
		$Panel/Label.text = UpgradeTrackRef.GetUpgradeName()
		$Panel.visible = true
	


func _on_mouse_exited() -> void:
	$Panel.visible = false
