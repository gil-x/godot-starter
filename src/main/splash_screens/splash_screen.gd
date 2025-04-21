extends Control

signal splash_screen_ended

@onready var media_container: Control = %MediaContainer

@export var fade_in_duration: float = 0.25
@export var scale_in_duration: float = 0.5
@export var display_time: float = 4.0
@export var fade_out_duration: float = 0.5
@export var scale_out_duration: float = 2.0
@export var sound: String

var tween : Tween
var asp : AudioStreamPlayer


func _ready():
	media_container.position = get_viewport_rect().size/2
	media_container.modulate = Color.TRANSPARENT
	media_container.scale = Vector2(0.5, 0.5)


func run() -> void:
	tween = create_tween().set_parallel(true)
	tween.tween_property(media_container, "modulate", Color.WHITE, fade_in_duration)
	tween.tween_property(media_container, "scale", Vector2(1.0, 1.0), scale_in_duration)
	asp = AudioPlayer.play_sound(sound)
	await get_tree().create_timer(display_time).timeout
	tween = create_tween().set_parallel(true)
	tween.tween_property(media_container, "modulate", Color.TRANSPARENT, fade_out_duration)
	tween.tween_property(media_container, "scale", Vector2(2.0, 2.0), scale_out_duration)
	await get_tree().create_timer(scale_out_duration).timeout
	_end()


func _end():
	if asp:
		AudioPlayer.fade_out(asp, 0.0)
	emit_signal("splash_screen_ended")
	self.queue_free()


func _on_zap_pressed() -> void:
	_end()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Debug.log("ui_cancel pushed")
		_end()
