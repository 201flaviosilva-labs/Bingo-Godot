extends ColorRect

export(PackedScene) var player_card_button_scene;


func _ready():
	new_game()
	pass

func new_game():
	for i in GameManager.PLAYER_CARD_BALLS:
		var btn = player_card_button_scene.instance();
		add_child(btn);
		btn.rect_position = Vector2(50 * i+ 10, 100)
		pass
	pass
