extends Node2D

class_name Ball

signal animation_finish

var ball_number: int = 0
var ball_color: Color = Color(1, 1, 1)
var tween: Tween
var to_kill: bool = false

func set_number(number: int) -> void:
	ball_number = number
	ball_color = Utils.calc_color(number)

func extraction_animation(end_position: Vector2, start_position: Vector2 = position, time: float = 3) -> void:
	position = start_position
	tween = create_tween()
	scale = Vector2(0,0)
	
	tween.tween_property(self, "position", end_position, time)
	tween.parallel().tween_property(self, "scale", Vector2(0.33,0.33), time / 4)
	
	tween.tween_property(self, "scale", Vector2(0.25,0.25), time / 4)
	tween.finished.connect(_animation_finish)

func move_side_animation(end_position: Vector2, time: float = 1) -> void:
	tween = create_tween()
	tween.tween_property(self, "position", end_position, time)
	
	if to_kill:
		tween.parallel().tween_property(self, "scale", Vector2(0, 0), time / 3)
		tween.parallel().tween_property(self, "modulate", Color(1,1,1,0), time / 3)
		tween.tween_callback(_kill)

func _ready():
	$Label.text = str(ball_number)
	$Sprite2D.modulate = ball_color

func _animation_finish() -> void:
	animation_finish.emit()

func _kill() -> void:
	get_parent().remove_child(self)
	queue_free()
