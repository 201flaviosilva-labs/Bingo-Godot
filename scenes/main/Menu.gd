extends Control

signal reset_click

@onready var initial_menu: VBoxContainer = $PanelContainer/InitialMenu
@onready var pause_menu: VBoxContainer = $PanelContainer/PauseMenu
@onready var win_menu: VBoxContainer = $PanelContainer/WinMenu
@onready var message: RichTextLabel = $PanelContainer/WinMenu/Message
@onready var max_balls_h_slider: HSlider = $PanelContainer/InitialMenu/MaxBallsHSlider
@onready var max_balls_label: Label = $PanelContainer/InitialMenu/MaxBallsLabel

var is_game_stated: bool = false

func game_end(text: String) -> void:
	get_tree().paused = true
	message.text = "[center]" + text + "[/center]"
	win_menu.show()
	show()

func _ready() -> void:
	_reset()

func _input(event: InputEvent) -> void:
	if not is_game_stated: return;
	if event.is_action_pressed("ui_cancel"):
		_resume() if get_tree().paused else _pause()

func _reset() -> void:
	is_game_stated = false
	get_tree().paused = true
	
	max_balls_h_slider.value = GameManager.NUMBER_OF_BALLS
	max_balls_label.text = "Balls: " + str(GameManager.NUMBER_OF_BALLS)
	
	initial_menu.show()
	pause_menu.hide()
	win_menu.hide()
	show()

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
	emit_signal("reset_click")

func _on_pause_button_pressed() -> void:
	_pause()

func _on_resume_button_pressed() -> void:
	_resume()

func _on_reset_button_pressed() -> void:
	emit_signal("reset_click")
	_reset()

func _on_back_button_pressed() -> void:
	win_menu.hide()
	emit_signal("reset_click")
	_reset()

func _on_max_balls_h_slider_value_changed(value: float) -> void:
	GameManager.NUMBER_OF_BALLS = value
	max_balls_label.text = "Balls: " + str(GameManager.NUMBER_OF_BALLS)
