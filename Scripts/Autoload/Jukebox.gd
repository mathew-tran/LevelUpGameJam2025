extends AudioStreamPlayer

class_name JukeboxPlayer

enum MUSIC_TYPE {
	NONE,
	CONTINUE,
	SHOP,
	FIGHT,
	DEAD
}

var SoundChannels = [
	]

func _ready() -> void:
	SoundChannels.append(self)
	SoundChannels.append($Shop)
	SoundChannels.append($Dead)
	ChangeAudio(-1000)
	PlayMusic(MUSIC_TYPE.NONE)

func ChangeAudio(volumeDB):
	for channel in SoundChannels:
		channel.volume_db = volumeDB
	
	
func Resume(channel : AudioStreamPlayer):
	
	if channel.get_playback_position() == 0.0:
		channel.volume_db = 0
		channel.play()
	else:
		channel.volume_db = -100
		channel.play(channel.get_playback_position())
		var tween = get_tree().create_tween()
		tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		tween.tween_property(channel, "volume_db", 0, .1)

func Stop(channel):
	if channel.stream_paused or channel.playing == false:
		return
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(channel, "volume_db", -1000, .1)
	await tween.finished
	channel.stream_paused = true
	
		
func PlayMusic(musicType : MUSIC_TYPE):
	print("PLAY: " + str(MUSIC_TYPE.keys()[musicType]))
	await Stop($Shop)
	await Stop(self)
	await Stop($Dead)
	match musicType:
		MUSIC_TYPE.SHOP:
			Resume($Shop)
		MUSIC_TYPE.DEAD:
			Resume($Dead)
		MUSIC_TYPE.FIGHT:
			Resume(self)
		MUSIC_TYPE.NONE:
			ChangeAudio(-10000)
			pass
		MUSIC_TYPE.CONTINUE:
			return

	
func PlaySFX(audiostream : AudioStream):
	if audiostream:
		$SFX.stream = audiostream
		$SFX.play()
		
func PlaySFXMenu(audiostream : AudioStream):
	if audiostream:
		$SFXMenu.stream = audiostream
		$SFXMenu.play()
	
func PlayXPSFX(pitch):
	$EXP.pitch_scale = pitch
	$EXP.play()
