extends Sprite2D

var Progress = 0
var BasePitch = 1
var TextAmount = 0
var SpeechSpeed = 2

func Talk(data):
	Progress = 0
	$FinishedSpeechTimer.stop()
	$SpeechTimer.stop()
	$Label.text = ""
	$Label.visible_characters = 0
	if data.has("message"):
		$Label.text = data["message"]
		TextAmount = len(data["message"])
	if data.has("audio"):
		$AudioStreamPlayer2D.stream = data["audio"]
	if data.has("pitch"):
		BasePitch = data["pitch"]
	visible = true
	
func _process(delta: float) -> void:
	if Progress > 1:
		pass
	else:
		Progress += delta * SpeechSpeed
		if $SpeechTimer.time_left == 0.0:
			$AudioStreamPlayer2D.pitch_scale = BasePitch + randf_range(.1,.2)
			$AudioStreamPlayer2D.play()
			$SpeechTimer.start()
		$Label.visible_characters = lerp(0, TextAmount, Progress)
		if Progress >= 1:
			$FinishedSpeechTimer.start()
			$AudioStreamPlayer2D.stop()


func _on_finished_speech_timer_timeout() -> void:
	visible = false
