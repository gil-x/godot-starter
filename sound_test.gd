extends Control


func _ready() -> void:
	Game.change_state(Game.State.IN_GAME)


func _on_button_do_pressed() -> void:
	AudioPlayer.play_sound("sfx_do")


func _on_button_re_pressed() -> void:
	AudioPlayer.play_sound("sfx_re")


func _on_button_mi_pressed() -> void:
	AudioPlayer.play_sound("sfx_mi")


func _on_button_fa_pressed() -> void:
	AudioPlayer.play_sound("sfx_fa")


func _on_button_sol_pressed() -> void:
	AudioPlayer.play_sound("sfx_sol")


func _on_button_la_pressed() -> void:
	AudioPlayer.play_sound("sfx_la")


func _on_button_si_pressed() -> void:
	AudioPlayer.play_sound("sfx_si", -10.0, true)


func _on_play_once_pressed() -> void:
	var music = AudioPlayer.play_sound("music_boss_theme", -10.0)
	music.add_to_group("musics")


func _on_play_loop_pressed() -> void:
	var music = AudioPlayer.play_sound("music_boss_theme", -10.0, true)
	music.add_to_group("musics")


func _on_pause_play_pressed() -> void:
	var musics = get_tree().get_nodes_in_group("musics")
	for music in musics:
		AudioPlayer.pause(music)


func _on_stop_pressed() -> void:
	var musics = get_tree().get_nodes_in_group("musics")
	for music in musics:
		AudioPlayer.stop(music)


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(Game.MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(Game.MUSIC_BUS_ID, value < .05)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(Game.SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(Game.SFX_BUS_ID, value < .05)
