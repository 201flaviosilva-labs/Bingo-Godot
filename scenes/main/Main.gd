extends Control

@export var Ball_Scene: PackedScene

@onready var balls_wrapper: Node2D = $BallsWrapper
@onready var kill_balls_wrapper: Node2D = $KillBallsWrapper
@onready var has_ball_asp: AudioStreamPlayer = $Sounds/HasBall
@onready var no_ball_asp: AudioStreamPlayer = $Sounds/NoBall
@onready var card: Panel = $UI/Card
@onready var menu: Control = $UI/Menu

const BALLS_START_POSITION = Vector2(700, 0)
const BALLS_MARGIN = 76
const MAX_BALLS_STACK = 9 # Max of the balls in the stack/path of the last extracted balls

var missing_player_numbers: int = GameManager.NUMBER_PLAYER_CARD_BALLS # number of player ball left to match
var missing_extract_ball: int = GameManager.NUMBER_EXTRACTION_BALLS # number of ball left to extract

func _ready():
	_reset()

# Resets the balls, player card, and all game
func _reset() -> void:
	GameManager.generate_balls()
	card.reset()
	
	missing_player_numbers = GameManager.NUMBER_PLAYER_CARD_BALLS
	missing_extract_ball = GameManager.NUMBER_EXTRACTION_BALLS
	
	has_ball_asp.stop()
	no_ball_asp.stop()
	
	for ball: Ball in balls_wrapper.get_children():
		balls_wrapper.remove_child(ball)
		ball.queue_free()

# Main function!
# get a new ball, render, and start the animation
# Counts left ball and check the end of the game
func _new_ball() -> void:
	if missing_extract_ball <= 0: # End game
		menu.game_end(GameManager.MESSAGES.LOSE)
		return;

	if balls_wrapper.get_children().size() >= MAX_BALLS_STACK:
		_move_children_ball()
	
	var new_ball: Ball = Ball_Scene.instantiate()
	var number = GameManager.get_next_ball_number()
	var children = balls_wrapper.get_children()
	
	missing_extract_ball -= 1
	
	new_ball.set_number(number)
	balls_wrapper.add_child(new_ball)
	new_ball.extraction_animation(
		Vector2(BALLS_MARGIN * children.size(), 0),
		BALLS_START_POSITION,
		GameManager.BALL_EXTRACTION_ANIMATION - 0.1 * children.size()
		)
	
	new_ball.animation_finish.connect(_ended_ball_animation.bind(number))

# Opens the end game Pop up
func _end_game() -> void:
	if missing_player_numbers == 0: menu.game_end(GameManager.MESSAGES.WIN)
	else: menu.game_end(GameManager.MESSAGES.LOSE)

# Move extracted balls to the left
# Remove last ball (the left one) 
func _move_children_ball() -> void:
	var kill_child = balls_wrapper.get_children()[0]
	kill_child.to_kill = true
	
	for ball: Ball in balls_wrapper.get_children():
		ball.move_side_animation(Vector2(ball.position.x - BALLS_MARGIN, 0))
	
	balls_wrapper.remove_child(kill_child)
	kill_balls_wrapper.add_child(kill_child)

# Play sound and mark on player card
func _ended_ball_animation(number: int) -> void:
	if Utils.player_has_number(number):
		missing_player_numbers -= 1
		card.mark_number(number)
		has_ball_asp.play()
		
	else: no_ball_asp.play()

# Timer
func _on_ball_extraction_timer_timeout() -> void:
	_new_ball()

# Event reset from the Menu node (from the reset button)
func _on_menu_reset_click() -> void:
	_reset()
