extends Node

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")

enum State {SPLASH_SCREENS, TITLE_SCREEN, IN_GAME, PAUSED, GAME_OVER}
var current_state : int


func change_state(state: int):
	match state:
		State.SPLASH_SCREENS:
			current_state = State.SPLASH_SCREENS
		State.TITLE_SCREEN:
			current_state = State.TITLE_SCREEN
		State.IN_GAME:
			current_state = State.IN_GAME
			Engine.time_scale = 1
		State.PAUSED:
			current_state = State.PAUSED
			Engine.time_scale = 0.01
		State.GAME_OVER:
			current_state = State.GAME_OVER
