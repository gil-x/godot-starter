extends Node

@export var main_menu : PackedScene


func debug_test():
	var empty = null
	Debug.log(empty)
	Debug.log(8)
	Debug.log("Hey, I am a string logged from main.")
	Debug.log([Vars.sample, "other", 99])


func load_main_menu():
	var main_menu_scene = main_menu.instantiate()
	call_deferred("add_child", main_menu_scene)
	

func _ready():
	debug_test()
	load_main_menu()
