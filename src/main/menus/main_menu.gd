extends Control

@onready var start_button: Button = %StartButton
var sound_test_scene: PackedScene = load("res://src/soundtest/sound_test.tscn")
var menu_music: AudioStreamPlayer

func _ready() -> void:	
	start_button.grab_focus()
	#menu_music = AudioPlayer.play_sound("music_out_there")
	menu_music = AudioPlayer.fade_in("music_out_there", 5.0, -10.0)


func _on_start_button_pressed() -> void:
	Debug.log("Start pressed")


func _on_sound_test_button_pressed() -> void:
	Debug.log("SoundTest pressed")
	AudioPlayer.fade_out(menu_music, 3.0)
	get_tree().change_scene_to_packed(sound_test_scene)
	
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
