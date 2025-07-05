extends Node2D

class_name Game

signal OnEXPUpdate(amount)

func AddEXP(amount):
	OnEXPUpdate.emit(amount)
	
