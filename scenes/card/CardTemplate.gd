extends Control

@export var CardButtonScene: PackedScene

@onready var grid: GridContainer = $PanelContainer/HorizontalContainer/VerticalContainer/GridContainer

# mark the button on the card as matched
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

# adds all the (15) buttons to the grid with ther numbers sorted
func _create_buttons() -> void:
	_remove_buttons()
	
	var values = GameManager.generate_player_card()
	
	for i in range(GameManager.NUMBER_PLAYER_CARD_BALLS):
		var new_button: Button = CardButtonScene.instantiate()
		var number = values[i]
		
		new_button.text = str(number)
		new_button["theme_override_colors/font_color"] = Utils.calc_color(number)
		
		if not GameManager.IS_AUTOPLAY_ON:
			new_button.pressed.connect(_on_card_button_pressed.bind(number, new_button))
		
		grid.add_child(new_button)

# remove all buttons form the grid
func _remove_buttons() -> void:
	var children = grid.get_children()
	
	for child: Control in children:
		if child.is_in_group("card_button"):
			grid.remove_child(child)
			child.queue_free()

# On manual play mark the number on the card on click
func _on_card_button_pressed(_number: int, _button: Button) -> void:
	pass
