#extends Node2D

#const MaxHP = 3
#var health = MaxHP

#func _ready() -> void:
	#$Healthbar.max_value = MaxHP


#func update_health_ui() -> void:
	#set_health_label()
	#set_health_bar()
	

#func set_health_bar() -> void:
	#$Healthbar.value = health

#func set_health_label() -> void:
	#$HealthLabel.text = "Health: %s" % health

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept"):
		#damage()

#func damage() ->void:
	#health -=1
	#if health < 0:
		#health = MaxHP
	#update_health_ui()
	
