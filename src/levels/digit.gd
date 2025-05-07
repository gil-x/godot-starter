extends Panel

@onready var label_digit: Label = %LabelDigit


var digit : int = 0 :
	set(value):
		digit = clamp(value, 0, 9)


func _refresh_digit_label():
	label_digit.text = str(digit)
	Debug.log(digit)


func _on_plus_pressed() -> void:
	digit += 1
	_refresh_digit_label()
	Debug.log(digit)


func _on_minus_pressed() -> void:
	digit -= 1
	_refresh_digit_label()


#func save():
	#Game.save_file.store_var(label_digit)
	#
#
#func load():
	#label_digit = Game.save_file.get_var(true)
