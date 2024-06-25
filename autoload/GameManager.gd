extends Node

const BALL_EXTRACTION_ANIMATION = 2.5 # Time of the ball extraction animation
const NUMBER_PLAYER_CARD_BALLS = 15 # Number of the number avaliable on the player card
const NUMBER_EXTRACTION_BALLS = 30 # Number of ball to extract
var MAX_RANGE_OF_BALLS = 60 # Max of the range of the ball ex: 1-60 or 1-90

const COLORS = {
	RED = Color(1,0,0), # 1,10
	YELLOW = Color(1,1,0), # 11, 20
	GREEN = Color(0,1,0), # 21, 30
	AQUA = Color(0,1,1), # 31, 40
	BLUE = Color(0,0,1), # 41, 50
	MAGENTA = Color(1,0,1), # 51, 60
	WHITE = Color(1,1,1), # 61, 70
	BLACK = Color(0,0,0), # 71, 80
	GREY = Color(0.5,0.5,0.5), # 81, 90
	BROWN = Color(0.62, 0.33, 0.17) # 91, 100
}

# Messages of the end of the game
const MESSAGES = {
	WIN = "NICE! BINGO! Now are part of the FABAMAQ team!",
	LOSE = "All balls was extracted and you lose :(. But you will be part of the FABAMAQ team anyway :).",
}

var balls = [] # Orded list of the extraction balls
var player_card_balls = [] # List sorted of the player numbers on the card

# Generate random numbers for the player (ex: 15)
func generate_player_card() -> Array:
	player_card_balls = range(1, MAX_RANGE_OF_BALLS + 1)
	player_card_balls.shuffle()
	player_card_balls = player_card_balls.slice(0, NUMBER_PLAYER_CARD_BALLS)
	player_card_balls.sort()
	return player_card_balls

func generate_balls() -> void:
	balls = range(1, MAX_RANGE_OF_BALLS + 1)
	balls.shuffle()

# Returns the next ball to be extract and animated
func get_next_ball_number() -> int:
	return balls.pop_front()
