extends Control

@export var CardButton_Scene: PackedScene

@onready var Grid: GridContainer = $NinePatchRect/GridContainer

var missing_numbers = GameManager.PLAYER_CARD_BALLS

func _ready() -> void:
	_create_buttons()

func _create_buttons() -> void:
	_remove_buttons()
	
	var values = GameManager.generate_player_card()
	
	for i in range(GameManager.PLAYER_CARD_BALLS):
		var new_button: Button = CardButton_Scene.instantiate()
		var number = values[i]
		
		new_button.text = str(number)
		new_button["theme_override_colors/font_color"] = Utils.calc_color(number)
		new_button.pressed.connect(_on_card_button_pressed.bind(number, new_button))
		
		Grid.add_child(new_button)

func _remove_buttons() -> void:
	var children = Grid.get_children()
	
	for child in children:
		if not child is Label:
			Grid.remove_child(child)
			child.queue_free()

func _on_card_button_pressed(number: int, button: Button) -> void:
	if not Utils.number_was_extrated(number): return;
	
	button.disabled = true
	missing_numbers -= 1
