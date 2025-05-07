extends Node

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")

enum State {SPLASH_SCREENS, TITLE_SCREEN, IN_GAME, PAUSED, GAME_OVER}
var current_state : int

#var save_path := "user://starter.save"
#var save_file = FileAccess.open("user://starter.save", FileAccess.WRITE) 
#func existing_file_save(path: String) -> bool:
	#return FileAccess.file_exists(path)
	

func change_state(state: int):
	match state:
		State.SPLASH_SCREENS:
			current_state = State.SPLASH_SCREENS
		State.TITLE_SCREEN:
			current_state = State.TITLE_SCREEN
		State.IN_GAME:
			current_state = State.IN_GAME
		State.PAUSED:
			current_state = State.PAUSED
		State.GAME_OVER:
			current_state = State.GAME_OVER
