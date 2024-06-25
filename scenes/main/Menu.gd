extends Control

signal reset_click

@onready var initial_menu: PanelContainer = $InitialMenu
@onready var pause_menu: PanelContainer = $PauseMenu
@onready var resume_button: Button = $PauseMenu/Container/ButtonsContainer/ResumeButton
@onready var reset_button: Button = $PauseMenu/Container/ButtonsContainer/ResetButton

var is_game_stated: bool = false

func _ready() -> void:
	_reset()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_toggle_pause()

func _reset() -> void:
	is_game_stated = false
	get_tree().paused = true
	pause_menu.hide()
	initial_menu.show()
	show()

func _toggle_pause() -> void:
	if not is_game_stated: return;
	_resume() if get_tree().paused else _pause()

func _resume() -> void:
	is_game_stated = true
	get_tree().paused = false
	pause_menu.hide()
	hide()

func _pause() -> void:
	get_tree().paused = true
	pause_menu.show()
	show()

func _on_play_button_pressed() -> void:
	initial_menu.hide()
	_resume()

func _on_reset_button_pressed() -> void:
	emit_signal("reset_click")
	_reset()

func _on_pause_button_pressed() -> void:
	_pause()

func _on_resume_button_pressed() -> void:
	_resume()
