extends Control

@onready var digits_containers: Control = %DigitsContainers

func _on_button_save_pressed() -> void:
	var datas: Array
	for child in digits_containers.get_children():
		if child is Digit:
			datas.append(child.digit)
	Game.save_data("digits", datas)


func _on_button_load_pressed() -> void:
	var loaded_digits = Game.load_data("digits")
	if loaded_digits:
		var digits = digits_containers.get_children()
		for i in len(loaded_digits):
			digits[i].digit = loaded_digits[i]
