extends Node

# calc the color for the provider number based in the 10
# ex: 1-10 red, 11-20 yellow
func calc_color(number: int) -> Color:
	var colors = GameManager.COLORS.values()
	var color_index = floor(number / 10) % colors.size()
	
	return colors[color_index]

# Check if the player card has the provied number
func player_has_number(number: int) -> bool:
	return GameManager.player_card_balls.has(number)
