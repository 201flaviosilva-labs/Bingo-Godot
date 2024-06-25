extends Control

@export var CardButton_Scene: PackedScene

@onready var grid: GridContainer = $NinePatchRect/GridContainer

func mark_number(number: int) -> void:
	var children = grid.get_children()
	
	for child: Control in children:
		if child.is_in_group("card_button") and child.text == str(number):
			child.disabled = true
			return;

func reset():
	_create_buttons()

func _ready() -> void:
	reset()

func _create_buttons() -> void:
	_remove_buttons()
	
	var values = GameManager.generate_player_card()
	
	for i in range(GameManager.PLAYER_CARD_BALLS):
		var new_button: Button = CardButton_Scene.instantiate()
		var number = values[i]
		
		new_button.text = str(number)
		new_button["theme_override_colors/font_color"] = Utils.calc_color(number)
		
		grid.add_child(new_button)

func _remove_buttons() -> void:
	var children = grid.get_children()
	
	for child: Control in children:
		if child.is_in_group("card_button"):
			grid.remove_child(child)
			child.queue_free()
