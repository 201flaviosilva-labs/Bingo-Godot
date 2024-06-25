extends Node

func calc_color(number: int) -> Color:
	var colors = GameManager.COLORS.values()
	var color_index = floor(number / 10) % colors.size()
	
	return colors[color_index]

func player_has_number(number: int) -> bool:
	return GameManager.player_card_balls.has(number)
