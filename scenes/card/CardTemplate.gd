extends Control

@export var CardButtonScene: PackedScene

@onready var grid: GridContainer = $PanelContainer/HorizontalContainer/VerticalContainer/GridContainer

var disabled_on_mark_button: bool = true

# mark the button on the card as matched
func mark_number(number: int) -> void:
	var children = grid.get_children()
	
	for child: Control in children:
		if child.is_in_group("card_button") and child.text == str(number):
			child.disabled = disabled_on_mark_button
			return;

func reset():
	_create_buttons([])

func _ready() -> void:
	reset()

# Create the card and add to the scene
func _create_buttons(values: Array) -> void:
	_remove_buttons()
	
	for i in range(values.size()):
		var new_button: Button = CardButtonScene.instantiate()
		var number = values[i]

		new_button.text = str(number)
		new_button["theme_override_colors/font_color"] = Utils.calc_color(number)
		
		_new_button_details(new_button, number)
		
		grid.add_child(new_button)

# remove all buttons form the grid
func _remove_buttons() -> void:
	var children = grid.get_children()
	
	for child: Control in children:
		if child.is_in_group("card_button"):
			grid.remove_child(child)
			child.queue_free()

func _new_button_details(_button: Button, _number: int) -> void:
	pass
