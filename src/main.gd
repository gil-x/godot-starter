extends Node


func debug_test():
	var empty = null
	Debug.log(empty)
	Debug.log(8)
	Debug.log("Hey, I am a string logged from main.")
	Debug.log([Vars.sample, "other", 99])


func _ready():
	debug_test()
