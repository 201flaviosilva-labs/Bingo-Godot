extends Control

signal reset_click

@onready var pause_menu: PanelContainer = $PauseMenu
@onready var resume_button: Button = $PauseMenu/VBoxContainer/HBoxContainer/ResumeButton
@onready var reset_button: Button = $PauseMenu/VBoxContainer/HBoxContainer/ResetButton

func _ready() -> void:
	_reset()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_toggle_pause()

func _reset() -> void:
	get_tree().paused = true
	show()

func _toggle_pause() -> void:
	_resume() if get_tree().paused else _pause()

func _resume() -> void:
	get_tree().paused = false
	pause_menu.hide()
	hide()

func _pause() -> void:
	get_tree().paused = true
	pause_menu.show()
	show()

func _on_reset_button_pressed() -> void:
	emit_signal("reset_click")
	_reset()

func _on_pause_button_pressed() -> void:
	_pause()

func _on_resume_button_pressed() -> void:
	_resume()
