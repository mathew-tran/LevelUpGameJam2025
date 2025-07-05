extends ProgressBar

@export var TimerRef : Timer

func _process(delta: float) -> void:
	value = 1 - float(TimerRef.time_left) / float(TimerRef.wait_time)
