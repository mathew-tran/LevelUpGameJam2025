extends Label

var data = {}
func _ready() -> void:
	text = ""
	Setup()
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", global_position - Vector2(0, 100), .5)
	await tween.finished
	queue_free()
	
func Setup():
	if data.has("text"):
		text = data["text"]
	if data.has("color"):
		modulate = data["color"]
