extends Node

const BALL_MARGIN = 50 

var current_ball
export(PackedScene) var new_ball;

func _ready():
	GameManager.randomize_balls()
	print(GameManager.sequence_balls)
	$PlayerCard.new_game()
	
	# Get all buttons
	for btn in get_tree().get_nodes_in_group("CardButton"):
		btn.connect("card_button_click", self, "_card_button_click")
	pass # Replace with function body.

func _card_button_click(text, btn):
	if str(current_ball) == text:
		$Sounds/RigthBallSound.play()
		btn.disabled = true
	pass

func _on_NewBallTimer_timeout():
	current_ball = GameManager.get_next_ball()
	print(current_ball)
	if current_ball == null:
		$NewBallTimer.stop()
		return
	
	if GameManager.player_has(current_ball):
		$Sounds/HasBallSound.play()
	else:
		$Sounds/NoHasBallSound.play()
	
	var newBall = new_ball.instance()
	add_child(newBall)
	newBall.rect_position = Vector2(900, 50)
	newBall.text = str(current_ball)
	
	var end_x = (GameManager.NUMBER_BALLS - GameManager.get_ball_size()) * BALL_MARGIN +10 
	$BallTween.interpolate_property(newBall, "rect_position:x", 900, end_x, 2.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$BallTween.start()
	pass # Replace with function body.
