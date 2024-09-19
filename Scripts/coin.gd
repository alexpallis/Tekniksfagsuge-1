extends Area2D

@onready var coin_noise = $"Coin noise"
@onready var game_manager = %GameManager



func _on_body_entered(body):
	if body.has_method("player"):
		game_manager.add_coin()
		self.queue_free()
		coin_noise.play()
