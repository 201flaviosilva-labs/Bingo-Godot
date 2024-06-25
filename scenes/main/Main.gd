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
const MAX_BALLS_STACK = 9

var missing_numbers = GameManager.PLAYER_CARD_BALLS

func _ready():
	_reset()

func _reset() -> void:
	GameManager.generate_balls()
	card.reset()
	
	missing_numbers = GameManager.PLAYER_CARD_BALLS
	
	for ball: Ball in balls_wrapper.get_children():
		balls_wrapper.remove_child(ball)
		ball.queue_free()

func _new_ball() -> void:
	var new_ball: Ball = Ball_Scene.instantiate()
	var number = GameManager.get_next_ball_number()
	
	if not number:
		menu.game_end(GameManager.MESSAGES.LOSE)
		return;
	
	if balls_wrapper.get_children().size() >= MAX_BALLS_STACK:
		_move_children_ball()
	
	var children = balls_wrapper.get_children()
	
	new_ball.set_number(number)
	balls_wrapper.add_child(new_ball)
	new_ball.extraction_animation(
		Vector2(BALLS_MARGIN * children.size(), 0),
		BALLS_START_POSITION,
		GameManager.BALL_EXTRACTION_ANIMATION - 0.1 * children.size()
		)
	
	new_ball.animation_finish.connect(_play_ball_sound.bind(number))

func _move_children_ball() -> void:
	var kill_child = balls_wrapper.get_children()[0]
	kill_child.to_kill = true
	
	for ball: Ball in balls_wrapper.get_children():
		ball.move_side_animation(Vector2(ball.position.x - BALLS_MARGIN, 0))
	
	balls_wrapper.remove_child(kill_child)
	kill_balls_wrapper.add_child(kill_child)

func _play_ball_sound(number: int) -> void:
	if Utils.player_has_number(number):
		missing_numbers -= 1
		card.mark_number(number)
		has_ball_asp.play()
		
		if missing_numbers == 0: _win_bingo()
		
	else: no_ball_asp.play()

func _win_bingo() -> void:
	menu.game_end(GameManager.MESSAGES.WIN)

func _on_ball_extraction_timer_timeout() -> void:
	_new_ball()

func _on_menu_reset_click() -> void:
	_reset()
