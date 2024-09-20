extends CharacterBody2D

var speed = 0.25
var player_chase = false
var player = null
var player_hittable = true
var health = 30
var player_inattack_zone = false
var can_take_damage = true
var attack_zone = false
var knockback_SPEED = 2
var is_inknockback = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var Player = $Player
@onready var invin_timer = $"invin timer"
@onready var knockback_timer = $"knockback timer"


func _physics_process(delta):
	deal_with_damage()

	if is_inknockback:
		position += (position - player.position) * knockback_SPEED * delta
		animated_sprite.play("Knock")


	if is_inknockback == false:
		if player_chase:
			position += (player.position - position) * speed * delta
			if (player.position.x - position.x) > 0:
				animated_sprite.flip_h = false
				animated_sprite.play("run")
			if (player.position.x - position.x) < 0:
				animated_sprite.flip_h = true
				animated_sprite.play("run")
		
		if attack_zone:
			position += (player.position - position) * speed * delta
			if (player.position.x - position.x) > 0:
				animated_sprite.flip_h = false
				animated_sprite.play("attack")
			if (player.position.x - position.x) < 0:
				animated_sprite.flip_h = true
				animated_sprite.play("attack")


	move_and_slide()


func _on_detection_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true


func _on_detection_body_exited(body):
	if body.has_method("player"):
		player = null
		player_chase = false


func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		attack_zone = true
		player_chase = false


func _on_hitbox_body_exited(body):
	if body.has_method("player"):
		attack_zone = false
		player_chase = true


func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			invin_timer.start()
			can_take_damage = false
			print("gumball health =", health)
			if health <= 0:
				self.queue_free()
			is_inknockback = true
			knockback_timer.start()


func _on_attack_area_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_attack_area_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false


func _on_invin_timer_timeout():
	can_take_damage = true

func enemy():
	pass


func _on_knockback_timer_timeout():
	is_inknockback = false
