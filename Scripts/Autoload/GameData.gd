extends Node

var ChosenCharacter : CharacterData
var CharactersYouWonWith : Array[CharacterData]

var Data = {}

func AddData(key, value):
	if Data.has(key):
		Data[key] += value
	else:
		Data[key] = value
