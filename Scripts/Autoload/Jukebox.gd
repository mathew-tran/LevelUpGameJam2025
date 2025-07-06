extends AudioStreamPlayer

class_name JukeboxPlayer

enum MUSIC_TYPE {
	NONE,
	CONTINUE,
	SHOP,
	FIGHT,
	DEAD
}

func _ready() -> void:
	play()
	$Shop.play()
	$Dead.play()
	
func PlayMusic(musicType : MUSIC_TYPE):
	print("PLAY: " + str(MUSIC_TYPE.keys()[musicType]))
	$Shop.stream_paused = true
	stream_paused = true
	$Dead.stream_paused = true
	match musicType:
		MUSIC_TYPE.SHOP:
			$Shop.stream_paused = false
		MUSIC_TYPE.DEAD:
			$Dead.stream_paused = false
		MUSIC_TYPE.FIGHT:
			stream_paused = false
		MUSIC_TYPE.NONE:
			pass
		MUSIC_TYPE.CONTINUE:
			return

	
func PlaySFX(audiostream : AudioStream):
	if audiostream:
		$SFX.stream = audiostream
		$SFX.play()
	
func PlayXPSFX(pitch):
	$EXP.pitch_scale = pitch
	$EXP.play()
