extends Control

@onready var play_button: Button = $VBoxContainer/PlayButton
@onready var reset_button: Button = $VBoxContainer/ResetButton

func _ready() -> void:
	_reset()

func _reset() -> void:
	play_button.text = "Play"
	reset_button.hide()
	get_tree().paused = true

func _on_play_button_pressed() -> void:
	get_tree().paused = !get_tree().paused
	
	if get_tree().paused:
		play_button.text = "Resume"
		reset_button.show()
	else:
		play_button.text = "Pause"
		reset_button.hide()

func _on_reset_button_pressed() -> void:
	_reset()
