extends Area2D

func _ready() -> void:
	Update()
	
func Update():
	var circleShape = ($CollisionShape2D.shape) as CircleShape2D
	circleShape.radius = 60.57 * Finder.GetGame().SubStatPickupRadius.Get().GetValue()
	
func _on_area_entered(area: Area2D) -> void:
	if area is Pickup:
		area.SetFollowing()
