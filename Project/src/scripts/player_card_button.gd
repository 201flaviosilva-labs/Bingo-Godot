extends Button

signal card_button_click(card_text)

func _ready():
	pass


func _on_Button_pressed():
	emit_signal("card_button_click", text, self)
	pass # Replace with function body.
