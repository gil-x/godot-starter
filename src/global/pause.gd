extends CanvasLayer

@onready var content: Node = %Content

func _ready() -> void:
	content.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if Game.current_state == Game.State.PAUSED :
			Engine.time_scale = 1.0
			Game.current_state = Game.State.IN_GAME
			content.visible = false
		elif Game.current_state == Game.State.IN_GAME:
			Engine.time_scale = 0.05
			Game.current_state = Game.State.PAUSED
			content.visible = true
