extends Node2D


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scens/main_menu.tscn")


func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://controls.tscn")
