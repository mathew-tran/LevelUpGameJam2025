extends Area2D

@export var Damage = 3.0
@export var TimeToLive = 4.0
@export var MinSize = .3
var Progress = 0
var OriginalScale = Vector2.ZERO
func _ready() -> void:
	TimeToLive *= randf_range(.9, 1.3)
	rotation_degrees = randf_range(0, 360)
	scale = (MinSize + randf_range(.9, 1.5)) * Vector2.ONE
	OriginalScale = scale
	
func _process(delta: float) -> void:
	Progress += delta / TimeToLive
	scale = lerp(OriginalScale, Vector2.ZERO, Progress)
	if Progress >= 1:
		queue_free()
	
func _on_poll_timer_timeout() -> void:
	var areas = get_overlapping_bodies()
	for area in areas:
		var bTakeDamage = true
		if area is Enemy:
			area.TakeDamage(Damage)
