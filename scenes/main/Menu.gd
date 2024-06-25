extends Control

signal reset_click

@onready var initial_menu: VBoxContainer = $PanelContainer/InitialMenu
@onready var pause_menu: VBoxContainer = $PanelContainer/PauseMenu
@onready var win_menu: VBoxContainer = $PanelContainer/WinMenu
@onready var message: RichTextLabel = $PanelContainer/WinMenu/Message
@onready var max_balls_h_slider: HSlider = $PanelContainer/InitialMenu/MaxBallsHSlider
@onready var max_balls_label: Label = $PanelContainer/InitialMenu/MaxBallsLabel

var is_game_stated: bool = false # Used to block "esc" key on initial menu 

# Stops the game and shows the win/lose pop up with a message
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

# Resets the UI
# Opens the initial menu
func _reset() -> void:
	is_game_stated = false
	get_tree().paused = true
	
	max_balls_h_slider.value = GameManager.MAX_RANGE_OF_BALLS
	max_balls_label.text = "Balls: " + str(GameManager.MAX_RANGE_OF_BALLS)
	
	initial_menu.show()
	pause_menu.hide()
	win_menu.hide()
	show()

# Resumes the gameand hides the modal
func _resume() -> void:
	get_tree().paused = false
	pause_menu.hide()
	hide()

# Pauses the game and shows the pause menu
func _pause() -> void:
	get_tree().paused = true
	pause_menu.show()
	show()

# Button on initial menu
func _on_play_button_pressed() -> void:
	is_game_stated = true
	initial_menu.hide()
	_resume()
	emit_signal("reset_click")

# Button on Main scene
func _on_pause_button_pressed() -> void:
	_pause()

# Button on pause menu
func _on_resume_button_pressed() -> void:
	_resume()

# Button on pause menu
func _on_reset_button_pressed() -> void:
	emit_signal("reset_click")
	_reset()

# Button on Win menu
func _on_back_button_pressed() -> void:
	win_menu.hide()
	emit_signal("reset_click")
	_reset()

func _on_max_balls_h_slider_value_changed(value: float) -> void:
	GameManager.MAX_RANGE_OF_BALLS = value
	max_balls_label.text = "Balls: " + str(GameManager.MAX_RANGE_OF_BALLS)
