extends AudioStreamPlayer

class_name JukeboxPlayer

enum MUSIC_TYPE {
	NONE,
	CONTINUE,
	SHOP,
	DEAD
}

func PlayMusic(musicType : MUSIC_TYPE):
	print("PLAY: " + str(MUSIC_TYPE.keys()[musicType]))
	match musicType:
		MUSIC_TYPE.SHOP:
			stream = load("res://Audio/Music/leveup25-shop-music.ogg")
		MUSIC_TYPE.DEAD:
			stream = load("res://Audio/SFX/levelup25-dead (2).ogg")
		MUSIC_TYPE.NONE:
			stream = null
			stop()
		MUSIC_TYPE.CONTINUE:
			return
	play()

	
func PlaySFX(audiostream : AudioStream):
	if audiostream:
		$SFX.stream = audiostream
		$SFX.play()
	
