extends RigidBody2D

@export var CharacterDataRef : CharacterData


func Setup():
	$Sprite2D.texture = CharacterDataRef.Picture
