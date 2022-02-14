extends Node

const NUMBER_BALLS = 10
const PLAYER_CARD_BALLS = 5

var sequence_balls = []
var player_card_ball = []
var rng = RandomNumberGenerator.new();

# Start a new game
func randomize_balls():
	randomize()
	for i in NUMBER_BALLS:
		sequence_balls.append(i + 1)
		pass
	
	# Shuffle the balls
	sequence_balls.shuffle()
	
	generate_player_card()
	pass

func generate_player_card():
	var temp_balls = []
	for i in NUMBER_BALLS:
		temp_balls.append(sequence_balls[i])

	for i in PLAYER_CARD_BALLS:
		var index = rng.randi_range(0, temp_balls.size())
		player_card_ball.append(temp_balls[index])
		temp_balls.pop_at(index)
	
	player_card_ball.sort()
	
	print(player_card_ball)
	pass

func get_next_ball():
	return sequence_balls.pop_front()
	pass
