extends Control

signal all_splash_screens_ended

@onready var screens: Node = %Screens
@export var wait_before_start : float = 0.0
@export var wait_between_screens : float = 0.0

var splash_screens = []


func _ready():
	for child in screens.get_children():
		Debug.log(["Cloning", child])
		var clone = child.duplicate()
		splash_screens.append(clone)
		child.queue_free()
	await get_tree().create_timer(wait_before_start).timeout
	_display_screen()


func _display_screen():
	await get_tree().create_timer(wait_between_screens).timeout
	var screen = splash_screens.pop_front()
	Debug.log(["Displaying", screen])
	screen.splash_screen_ended.connect(self._on_splash_screen_ended)
	screens.call_deferred("add_child", screen)
	screen.call_deferred("run")


func _on_splash_screen_ended():
	if len(splash_screens) > 0:
		_display_screen()
	else:
		emit_signal("all_splash_screens_ended")
