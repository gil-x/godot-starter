extends Node

@export var splash_screens : PackedScene
@export var main_menu : PackedScene


func _debug_test():
	var empty = null
	Debug.log(empty)
	Debug.log(8)
	Debug.log("Hey, I am a string logged from main.")
	Debug.log([Vars.sample, "other", 99])


func _load_splash_screens():
	Game.change_state(Game.State.SPLASH_SCREENS)
	var splash_screens_scene = splash_screens.instantiate()
	splash_screens_scene.all_splash_screens_ended.connect(self._on_all_splash_screens_ended)
	call_deferred("add_child", splash_screens_scene)


func _load_main_menu():
	var main_menu_scene = main_menu.instantiate()
	call_deferred("add_child", main_menu_scene)


func _ready():
	_debug_test()
	_load_splash_screens()


func _on_all_splash_screens_ended():
	_load_main_menu()
