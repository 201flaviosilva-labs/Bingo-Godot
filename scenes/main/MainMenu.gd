extends Node2D

@export var Ball_Scene: PackedScene

func _ready():
	pass

func _on_new_ball_button_pressed():
	var new_ball = Ball_Scene.instantiate()
	new_ball.set_properties(Vector2(100, 200), 2, Color(1,0,0), Vector2(200, 100))
	add_child(new_ball)
