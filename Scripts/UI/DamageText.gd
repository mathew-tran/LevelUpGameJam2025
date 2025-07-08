extends Label

var data = {}
var timeFrame = .5
var targetPosition = Vector2(0, 100)
func _ready() -> void:
	text = ""
	Setup()
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", global_position - targetPosition, timeFrame)
	await tween.finished
	queue_free()
	
func Setup():
	if data.has("text"):
		text = data["text"]
	if data.has("color"):
		modulate = data["color"]
	if data.has("time"):
		timeFrame = data["time"]
	if data.has("position"):
		targetPosition = data["position"]
