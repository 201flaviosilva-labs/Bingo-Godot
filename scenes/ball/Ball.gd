extends Node2D

class_name Ball

var ball_number: int = 0
var ball_color: Color = Color(1, 1, 1)
var ball_end_position: Vector2 = Vector2.ZERO

func set_properties(start_position: Vector2, number: int, color: Color, end_position: Vector2) -> void:
	position = start_position
	ball_number = number
	ball_color = color
	ball_end_position = end_position

func _ready():
	$Label.text = str(ball_number)
	$Sprite2D.modulate = ball_color
