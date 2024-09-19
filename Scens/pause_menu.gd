extends Control

@export var enemy_spawner : Enemyspawner

func _ready() -> void:
	hide()
	enemy_spawner.connect("toggel_game_paused", _on_enemy_spawner_toggle_game_paused)


func _on_enemy_spawner_toggle_game_paused(is_paused : bool):
	if(is_paused):
		show()
	else:
		hide()


func _on_quitbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://Scens/main_menu.tscn")


func _on_resumebutton_pressed() -> void:
	enemy_spawner.game_paused = false
