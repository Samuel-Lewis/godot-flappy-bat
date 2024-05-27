extends CanvasLayer

func hide_all():
	for c in get_children():
		c.hide()

func show_main_menu():
	hide_all()
	$MainMenu.show()

func show_game_ui():
	hide_all()
	$GameUi.show()

func show_game_over():
	hide_all()
	$GameOver.show()

func _on_quit_button_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit()

func _on_mute_button_pressed():
	Audio.toggle_mute()
	Audio.play_ui()

func _on_main_menu_button_pressed():
	Audio.play_ui()
	show_main_menu()
