extends CharacterBody2D

const  SPEED = 200
var player_chase = false
var player_shoot = false
var player_flee = false
var player = null
const knock_back_SPEED = 150

var health = 100
var player_inattack_zone = false
var can_take_damage = true

@onready var animated_sprite = $AnimatedSprite2D
@onready var invin_timer = $"invin timer"
@onready var attack_cooldown_timer = $"attack cooldown timer"
@onready var attack_timer = $"attack timer"

func _physics_process(delta):
	deal_with_damage()
	
	if player_chase:
		position += (player.position - position)/SPEED

		if(player.position.x - position.x) < 0 and (player.position.y - position.y) == 0:
			animated_sprite.flip_h = true
			animated_sprite.play("walk left right")
		
		if(player.position.x - position.x) > 0 and (player.position.y - position.y) == 0:
			animated_sprite.flip_h = false
			animated_sprite.play("walk left right")
		
		if(player.position.y - position.y) < 0:
			animated_sprite.play("walk up")
		
		if(player.position.y - position.y) > 0:
			animated_sprite.play("walk down")
	
	else:
		animated_sprite.play("idl down")
	
	if player_flee:
		if player_chase:
			position += (player.position + position)/SPEED

			if(player.position.x - position.x) < 0 and (player.position.y - position.y) == 0:
				animated_sprite.flip_h = true
				animated_sprite.play("walk left right")

			if(player.position.x - position.x) > 0 and (player.position.y - position.y) == 0:
				animated_sprite.flip_h = false
				animated_sprite.play("walk left right")

			if(player.position.y - position.y) < 0:
				animated_sprite.play("walk up")

			if(player.position.y - position.y) > 0:
				animated_sprite.play("walk down")


	move_and_slide()
func _on_flee_area_body_entered(body):
	if body.has_method("player"):
		player_flee = true
		player_shoot = false


func _on_flee_area_body_exited(body):
	if body.has_method("player"):
		player_flee = false
		player_shoot = true

func _on_attack_area_body_entered(body):
	if body.has_method("player"):
		player_chase = false
		player_shoot = true


func _on_attack_area_body_exited(body):
	if body.has_method("player"):
		player_chase = true
		player_shoot = false


func _on_detection_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true

func _on_detection_body_exited(body):
	if body.has_method("player"):
		player = null
	player_chase = false


func _on_bjørn_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true

func _on_bjørn_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			invin_timer.start()
			can_take_damage = false
			print("bjørn health =", health)
			if health <= 0:
				self.queue_free()


func _on_invin_timer_timeout():
	can_take_damage = true
