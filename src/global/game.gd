extends Node

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")

enum State {SPLASH_SCREENS, TITLE_SCREEN, IN_GAME, PAUSED, GAME_OVER}
var current_state : int
var save_path := "user://starter.save"
#var save_file = FileAccess.open("user://starter.save", FileAccess.WRITE) 
var save_dict: Dictionary


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


func save_data(key: String, values: Array) -> void:
	if key in save_dict:
		Debug.log("Data with key '" + key + "' were overwrited")
		return
	for v in values:
		if not(v is String or v is int or v is float or v is bool):
			Debug.log("Can't save array of datas because one value is not String,int,float or bool")
			return
	save_dict[key] = values
	var json_string = JSON.stringify(save_dict)
	var save_file = FileAccess.open(save_path, FileAccess.WRITE) 
	save_file.store_line(json_string)


func load_data(key: String) -> Variant:
	if not FileAccess.file_exists(save_path):
		Debug.log("No savefile named found at " + save_path)
		return null
	var save_file = FileAccess.open(save_path, FileAccess.READ)
	var test_json_conv = JSON.new()
	test_json_conv.parse(save_file.get_as_text())
	var data = test_json_conv.get_data()
	Debug.log(data[key])
	return data[key]
