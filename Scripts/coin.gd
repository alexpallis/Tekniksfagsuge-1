extends Area2D

@onready var game_manager = %GameManager
@onready var coin_noise = $"Coin noise"


func _on_body_entered(body):
	coin_noise.play()
	if body.has_method("player"):
		game_manager.add_coin()
		self.queue_free()
