extends CanvasLayer

@onready var content: Node = %Content
var mainmenu_scene: PackedScene = load("res://src/main/menus/main_menu.tscn")

func _ready() -> void:
	content.visible = false
	Debug.log(["Engine.time_scale:", Engine.time_scale])


func _pause() -> void:
	Game.current_state = Game.State.PAUSED
	get_tree().paused = true
	content.visible = true
	AudioPlayer.pause_all()


func _unpause() -> void:
	Game.current_state = Game.State.IN_GAME
	get_tree().paused = false
	content.visible = false
	AudioPlayer.pause_all()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if Game.current_state == Game.State.PAUSED :
			_unpause()
		elif Game.current_state == Game.State.IN_GAME:
			_pause()


func _on_back_to_main_menu_pressed() -> void:
	_unpause()
	AudioPlayer.kill_all()
	get_tree().change_scene_to_packed(mainmenu_scene)
