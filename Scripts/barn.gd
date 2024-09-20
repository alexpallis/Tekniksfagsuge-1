extends CharacterBody2D

const  SPEED = 120
var player_chase = false
var player = null
var knockback_SPEED = 400

var health = 100
var player_inattack_zone = false
var can_take_damage = true
var is_inknockback = false

@onready var knockback_timer = $"knockback timer"
@onready var animated_sprite = $AnimatedSprite2D
@onready var invin_timer = $"invin timer"



func _physics_process(delta):
	deal_with_damage()
	move_and_slide()

	if is_inknockback == false:
		if player_chase:
			position += (position - player.position).normalized() * SPEED * delta 

			if(player.position.x - position.x) < 0:
				animated_sprite.flip_h = true
				animated_sprite.play("walk left right")
			
			if(player.position.x - position.x) > 0:
				animated_sprite.flip_h = false
				animated_sprite.play("walk left right")	
		
		else:
			animated_sprite.play("idl down")

	if is_inknockback:
		position += (position - player.position).normalized() * knockback_SPEED * delta
		animated_sprite.flip_h = false
		animated_sprite.play("Knock")



func _on_detection_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true

func _on_detection_body_exited(body):
	if body.has_method("player"):
		player = null
		player_chase = false


func _on_ghost_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true

func _on_ghost_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			invin_timer.start()
			can_take_damage = false
			print("ghost health =", health)
			if health <= 0:
				self.queue_free()
			is_inknockback = true
			knockback_timer.start()


func _on_invin_timer_timeout():
	can_take_damage = true


func _on_knockback_timer_timeout():
	is_inknockback = false
