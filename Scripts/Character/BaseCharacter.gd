extends RigidBody2D

@export var CharacterDataRef : CharacterData


func Setup():
	$Sprite2D.texture = CharacterDataRef.Picture

func _on_shoot_timer_timeout() -> void:
	if CharacterDataRef.Projectile:
		var instance = CharacterDataRef.Projectile.instantiate()
		instance.global_position = global_position
		Finder.GetBulletsGroup().add_child(instance)
