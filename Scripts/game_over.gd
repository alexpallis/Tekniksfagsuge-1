extends CanvasLayer

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Scens/game.tscn")
	print("jo")


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scens/main_menu.tscn")
