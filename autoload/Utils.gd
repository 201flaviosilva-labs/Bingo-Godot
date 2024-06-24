extends Node

func calc_color(number: int) -> Color:
	var colors = GameManager.COLORS.values()
	
	var color_index = floor(number / 10) % colors.size()
	return colors[color_index]

func generate_player_card() -> Array:
	var balls = range(1, GameManager.NUMBER_OF_BALLS + 1)
	balls.shuffle()
	balls = balls.slice(0, GameManager.PLAYER_CARD_BALLS)
	balls.sort()
	return balls
