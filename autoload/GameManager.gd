extends Node

const NUMBER_OF_BALLS = 30
const PLAYER_CARD_BALLS = 15

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

var balls = []
var extrated_balls = []
var player_card_balls = []

func generate_player_card() -> Array:
	player_card_balls = range(1, GameManager.NUMBER_OF_BALLS + 1)
	player_card_balls.shuffle()
	player_card_balls = player_card_balls.slice(0, GameManager.PLAYER_CARD_BALLS)
	player_card_balls.sort()
	return player_card_balls

func generate_balls() -> void:
	balls = range(1, GameManager.NUMBER_OF_BALLS + 1)
	balls.shuffle()
	extrated_balls = []

func get_next_ball_number():
	if not balls.size(): return
	var n = balls.pop_front()
	extrated_balls.append(n)
	return n
