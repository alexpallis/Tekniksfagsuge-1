extends CanvasLayer

#@export var health



#pass
#func _ready() -> void:
	#$healthbar.max_value = MaxHP
#pass


#func update_health_ui() -> void:
	#set_health_label()
	#set_health_bar()
	

#func set_health_bar() -> void:
	#$healthbar.value = health

#func set_health_label() -> void:
	#$healthbar/healthlabel.text = "Health: %s" % health

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept"):
		#damage()

#func damage() ->void:
	#health -=1
	#if health < 0:
		#health = MaxHP
	#update_health_ui()
