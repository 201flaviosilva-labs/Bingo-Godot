extends Node2D

@export var Ball_Scene: PackedScene

func _ready():
	pass

func _on_new_ball_button_pressed():
	var new_ball = Ball_Scene.instantiate()
	var number = randi_range(0, 90)
	new_ball.set_properties(
		Vector2(randi_range(100, 500), randi_range(100, 500)),
		number,
		Utils.calc_color(number),
		Vector2(200, 100)
		)
	add_child(new_ball)
