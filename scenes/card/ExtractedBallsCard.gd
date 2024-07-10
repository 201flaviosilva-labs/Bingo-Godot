extends "res://scenes/card/CardTemplate.gd"

func reset() -> void:
	disabled_on_mark_button = false
	var values = range(1, GameManager.MAX_RANGE_OF_BALLS + 1)
	
	_create_buttons(values)

func _new_button_details(new_button: Button, _number: int) -> void:
	new_button["theme_override_font_sizes/font_size"] = 16
	new_button.disabled = true
