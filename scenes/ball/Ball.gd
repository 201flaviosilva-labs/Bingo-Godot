extends Node2D

class_name Ball

var ball_number: int = 0
var ball_color: Color = Color(1, 1, 1)

func set_number(number: int, ) -> void:
	ball_number = number
	ball_color = Utils.calc_color(number)

func start_move_animation(end_position: Vector2, start_position: Vector2 = position, time: float = 0.5) -> void:
	position = start_position
	var tween = create_tween()
	
	tween.tween_property(self, "position", end_position, time)

func _ready():
	$Label.text = str(ball_number)
	$Sprite2D.modulate = ball_color
