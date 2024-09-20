extends CanvasLayer

@onready var Score = $Panel/Score_label

func set_dream_label():
	Score.text = "You have collected " + str(global.dreams_collected) + " dream(s)"




func _on_button_pressed() -> void:
	get_tree().quit()
