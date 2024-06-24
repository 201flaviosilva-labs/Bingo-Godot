extends Control

@export var Ball_Scene: PackedScene

@onready var BallsWrapper: Node2D = $BallsWrapper
@onready var has_ball_asp: AudioStreamPlayer = $Sounds/HasBall
@onready var no_ball_asp: AudioStreamPlayer = $Sounds/NoBall

const BALLS_START_POSITION = Vector2(696, 0)
const BALLS_MARGIN = 76
const MAX_BALLS_STACK = 9

func _ready():
	GameManager.generate_balls()

func _new_ball() -> void:
	var new_ball: Ball = Ball_Scene.instantiate()
	var number = GameManager.get_next_ball_number()
	
	if not number: return; # TODO: Fix
	if BallsWrapper.get_children().size() >= MAX_BALLS_STACK: _move_children_ball()
	
	var children = BallsWrapper.get_children()
	
	new_ball.set_number(number)
	BallsWrapper.add_child(new_ball)
	new_ball.extraction_animation(
		Vector2(BALLS_MARGIN * children.size(), 0),
		BALLS_START_POSITION,
		GameManager.BALL_EXTRACTION_ANIMATION - 0.1 * children.size()
		)
	
	new_ball.animation_finish.connect(_play_ball_sound.bind(number))

func _move_children_ball() -> void:
	var kill_child = BallsWrapper.get_children()[0]
	BallsWrapper.remove_child(kill_child) # TODO: Fix kill animation
	kill_child.queue_free()
	
	for ball in BallsWrapper.get_children():
		ball.move_side_animation(Vector2(ball.position.x - BALLS_MARGIN, 0))

func _play_ball_sound(number: int) -> void:
	has_ball_asp.play() if Utils.player_has_number(number) else no_ball_asp.play()

func _on_ball_extraction_timer_timeout() -> void:
	_new_ball()
