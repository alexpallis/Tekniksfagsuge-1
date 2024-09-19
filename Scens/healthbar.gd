extends ProgressBar

@export var player = Player

func _ready() -> void:
	player.healthChanged.connect(update)
	update()
	

func update	() -> void:
	value = player.currentHealth * 100 / player.health
	
	
