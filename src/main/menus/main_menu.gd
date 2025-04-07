extends Control

@onready var start_button: Button = %StartButton


func _ready() -> void:	
	start_button.grab_focus()


func _on_start_button_pressed() -> void:
	Debug.log("Start pressed")


func _on_sound_test_button_pressed() -> void:
	Debug.log("SoundTest pressed")
	
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
