extends Area2D

@onready var enemy_spawner = $"../EnemySpawner"

func _on_body_entered(body):
	if body.has_method("player"):
		enemy_spawner.add_coin()
		self.queue_free()
