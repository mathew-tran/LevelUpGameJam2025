extends ProgressBar

var EXPCache = 0
var GameRef : Game

var EXP = 0
var MaxEXP = 100
var Level = 0

signal LevelUp
func _ready() -> void:
	Finder.GetGame().OnEXPUpdate.connect(OnEXPUpdate)
	Update()
	
func OnEXPUpdate(amount):
	EXPCache += amount
	
func _process(delta: float) -> void:
	if EXPCache != 0:
		EXP += 1
		EXPCache -= 1
		if EXP >= MaxEXP:
			EXP = 0
			MaxEXP *= 1.2
			Level += 1
			LevelUp.emit()
		Update()

func Update():
	$Label.text = "Lv" + str(Level)
	value = float(EXP) / float(MaxEXP)
