extends Area2D

var MaxTimeLeft = 0
var TimeLeft = 5
var bHasBeenCompleted = false

func _ready() -> void:
	MaxTimeLeft = TimeLeft
	_on_poll_timer_timeout()
	
func _on_poll_timer_timeout() -> void:
	if bHasBeenCompleted:
		return
	var bodies = get_overlapping_bodies()
	var bHasPlayer = false
	for body in bodies:
		if body is BaseCharacter:
			bHasPlayer = true
			break
	if bHasPlayer:
		if $Timer.time_left == 0.0:
			$Timer.start()
			$AnimationPlayer.play("anim")
		$Label.text = "EXTRACTING..."
		$AudioStreamPlayer.play()
	else:
		$Timer.stop()
		$AnimationPlayer.pause()
		$Label.text = "EXTRACT DATA"
		
	$ProgressBar.value = 1- float(TimeLeft) / float(MaxTimeLeft)

func _on_timer_timeout() -> void:
	if bHasBeenCompleted:
		return
	TimeLeft -=1
	if TimeLeft <= 0:
		bHasBeenCompleted = true
		$MemoryDrive.DestroyMemory()
		GameData.AddData("Data Extracted", 1)
		queue_free()
		
