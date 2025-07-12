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
	
	EXPCache += amount * Finder.GetGame().SubStatTeamExperience.Get().GetValue()
	
func _process(delta: float) -> void:
	if EXPCache > 0.0:
		var amountToRemove = lerp(1.0, float(EXPCache) /10.0,.2)
		if amountToRemove >= MaxEXP:
			amountToRemove /= 20
		if amountToRemove <= 0:
			amountToRemove = 1
		EXP += amountToRemove
		EXPCache -= amountToRemove
		Jukebox.PlayXPSFX(lerp(1.0, 2.5, value))
		if EXP >= MaxEXP:
			EXP = 0
			MaxEXP *= 1.1
			if MaxEXP >= 4000:
				MaxEXP = 4000
			if Level >= 80:
				MaxEXP = 6000
			if Level >= 100:
				MaxEXP = 8000
			if Level >= 120:
				MaxEXP = 10000
				
			Level += 1
			OnLevelUp.emit()
		Update()

func Update():
	$Label.text = "Lv " + str(Level)
	value = float(EXP) / float(MaxEXP)
