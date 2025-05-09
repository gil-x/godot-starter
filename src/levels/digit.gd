extends Panel
class_name Digit

@onready var label_digit: Label = %LabelDigit


var digit : int = 0 :
	set(value):
		digit = clamp(value, 0, 9)
		_refresh_digit_label()


func _refresh_digit_label():
	label_digit.text = str(digit)
	Debug.log(digit)


func _on_plus_pressed() -> void:
	digit += 1


func _on_minus_pressed() -> void:
	digit -= 1
