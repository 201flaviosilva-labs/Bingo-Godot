extends "res://scenes/card/CardTemplate.gd"

signal finished_card

var missing_numbers = GameManager.NUMBER_PLAYER_CARD_BALLS # check how many number missing to mark, only for manual play

func reset():
	missing_numbers = GameManager.NUMBER_PLAYER_CARD_BALLS
	
	_create_buttons()

# On manual play mark the number on the card on click
func _on_card_button_pressed(number: int, button: Button) -> void:
	if not Utils.number_was_extrated(number): return;
	
	button.disabled = true
	missing_numbers -= 1
	
	if missing_numbers == 0: finished_card.emit()
