extends Node

var ChosenCharacter : CharacterData
var CharactersYouWonWith : Array[CharacterData]

var Data = {}

var bFirstTimeGame = true
var bFirstLevelup = true

enum DIFFICULTY {
	EASY,
	MEDIUM,
	HARD
}

var Difficulty = DIFFICULTY.EASY

signal OnDifficultySet(diff)

func SetDifficulty(difficulty):
	Difficulty = difficulty
	OnDifficultySet.emit(Difficulty)
	
func AddData(key, value):
	if Data.has(key):
		Data[key] += value
	else:
		Data[key] = value
