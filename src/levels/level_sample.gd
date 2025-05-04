extends Node

@onready var rigid_body_2d: RigidBody2D = $RigidBody2D

var ball: RigidBody2D


func _ready() -> void:
	Game.change_state(Game.State.IN_GAME)
	ball = rigid_body_2d.duplicate()
	while true:
		await get_tree().create_timer(5).timeout
		var clone = ball.duplicate()
		self.add_child(clone)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		await get_tree().create_timer(1).timeout
		body.call_deferred("queue_free")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		#add_child(Pause)
		Debug.log("Pause")
