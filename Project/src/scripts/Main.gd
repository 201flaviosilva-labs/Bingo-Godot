extends Node

var current_ball

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
		btn.disabled = true
		print("Same")
	pass

func _on_NewBallTimer_timeout():
	current_ball = GameManager.get_next_ball()
	print(current_ball)
	if current_ball == null:
		$NewBallTimer.stop()
	pass # Replace with function body.
