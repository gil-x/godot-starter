extends Node

var tween : Tween
# Naming convention sfx_ / music_ is mandatory!
var sounds = {
	"sfx_do": preload("res://assets/samples/sfx/notes/do.ogg"),
	"sfx_re": preload("res://assets/samples/sfx/notes/re.ogg"),
	"sfx_mi": preload("res://assets/samples/sfx/notes/mi.ogg"),
	"sfx_fa": preload("res://assets/samples/sfx/notes/fa.ogg"),
	"sfx_sol": preload("res://assets/samples/sfx/notes/sol.ogg"),
	"sfx_la": preload("res://assets/samples/sfx/notes/la.ogg"),
	"sfx_si": preload("res://assets/samples/sfx/notes/si.ogg"),
	"music_out_there": preload("res://assets/samples/music/out_there.ogg"),
	"music_boss_theme": preload("res://assets/samples/music/boss_theme.ogg"),
}


func _init_sound(sound_name: String) -> AudioStreamPlayer:
	var asp = AudioStreamPlayer.new()
	if sounds.has(sound_name):
		asp.stream = sounds[sound_name]
	else:
		push_error("No sound named '%s' found." % sound_name)
	if "sfx" in sound_name:
		asp.bus = "SFX"
		
		asp.name = "SFX_%s" % asp.get_instance_id()
	elif "music" in sound_name:
		asp.bus = "Music"
		asp.name = "MUSIC_%s" % asp.get_instance_id()
	return asp


func _free_audioplayer(asp: AudioStreamPlayer):
	await asp.finished
	asp.queue_free()


# Save returned asp in a var if you need to do something else with the played sound
func fade_in(sound_name: String, duration: float, max_volume: float = 0.0) -> AudioStreamPlayer:
	var asp := _init_sound(sound_name)
	asp.volume_db = -80.0
	tween = create_tween().set_parallel(true)
	tween.tween_property(asp, "volume_db", max_volume, duration)
	add_child(asp)
	asp.play()
	_free_audioplayer(asp)
	return asp


func fade_out(asp: AudioStreamPlayer, duration: float):
	tween = create_tween().set_parallel(true)
	tween.tween_property(asp, "volume_db", -80.0, duration)
	await tween.finished
	asp.queue_free()


# Save returned asp in a var if you need to do something else with the played sound
func play_sound(sound_name: String, initial_volume: float = 0.0, loop: bool = false) -> AudioStreamPlayer:
	var asp := _init_sound(sound_name)
	asp.volume_db = initial_volume
	add_child(asp)
	asp.play()
	if loop:
		_play_loop(asp)
	else:
		_free_audioplayer(asp)
	return asp


func _play_loop(asp: AudioStreamPlayer):
	while true:
		await asp.finished
		asp.seek(0.0)
		asp.play()


func pause(asp: AudioStreamPlayer):
	asp.stream_paused = asp.playing
	

func stop(asp: AudioStreamPlayer):
	asp.queue_free()
	

func pause_all():
	for asp in self.get_children():
		pause(asp)


func kill_all():
	for asp in self.get_children():
		asp.queue_free()
