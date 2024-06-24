extends Control

@export var CardButton_Scene: PackedScene

@onready var Grid: GridContainer = $GridContainer

func _ready() -> void:
	_create_buttons()

func _create_buttons() -> void:
	var values = Utils.generate_player_card()
	
	for i in range(GameManager.PLAYER_CARD_BALLS):
		var new_button: Button = CardButton_Scene.instantiate()
		var number = values[i]
		
		new_button.text = str(number)
		new_button["theme_override_colors/font_color"] = Utils.calc_color(number)
		new_button.button_down.connect(_on_button_pressed.bind(number, new_button))
		
		Grid.add_child(new_button)

func _on_button_pressed(number: int, button: Button) -> void:
	button.disabled = true
	print(number)
