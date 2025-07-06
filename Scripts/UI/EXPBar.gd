extends ProgressBar

class_name EXPBar

var EXPCache = 0
var GameRef : Game

var EXP = 0
var MaxEXP = 100
var Level = 0

signal OnLevelUp

func _ready() -> void:
	Finder.GetGame().OnEXPUpdate.connect(OnEXPUpdate)
	Update()
	
func OnEXPUpdate(amount):
	EXPCache += amount
	
func _process(delta: float) -> void:
	if EXPCache != 0:
		EXP += 1
		EXPCache -= 1
		Jukebox.PlayXPSFX(lerp(1.0, 2.5, value))
		if EXP >= MaxEXP:
			EXP = 0
			MaxEXP *= 1.2
			Level += 1
			OnLevelUp.emit()
		Update()

func Update():
	$Label.text = "Lv" + str(Level)
	value = float(EXP) / float(MaxEXP)
