extends Control

@export var CardButtonScene: PackedScene

@onready var grid: GridContainer = $PanelContainer/VBoxContainer/GridContainer

# TODO: Optimize this class because it's basiclly the same as the player Card

func mark_number(number: int) -> void:
	var children = grid.get_children()
	
	for child: Control in children:
		if child.text == str(number):
			child.disabled = false
			return;

func reset():
	_create_balls()

func _ready() -> void:
	reset()

func _create_balls() -> void:
	_remove_balls()
	
	var values = range(1, GameManager.MAX_RANGE_OF_BALLS + 1)
	
	for i in range(GameManager.MAX_RANGE_OF_BALLS):
		var new_button: Button = CardButtonScene.instantiate()
		var number = values[i]
		
		new_button.text = str(number)
		new_button["theme_override_colors/font_color"] = Utils.calc_color(number)
		new_button["theme_override_font_sizes/font_size"] = 16
		new_button.disabled = true
		
		grid.add_child(new_button)

func _remove_balls() -> void:
	var children = grid.get_children()
	
	for child: Control in children:
		grid.remove_child(child)
		child.queue_free()
