extends Area2D

@onready var game_manager = %GameManager
@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(delta):
	animated_sprite_2d.play("Dreamcat")

func _on_body_entered(body):
	if body.has_method("player"):
		game_manager.add_coin()
		self.queue_free()
