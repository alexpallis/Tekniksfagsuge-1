extends CharacterBody2D

var speed = 0.25
var player_chase = false
var player = null
var player_hittable = false
var health = 30
var player_inattack_zone = false
var can_take_damage = true

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $Timer
@onready var Player = $Player
@onready var cooldown = $Cooldown
@onready var invin_timer = $"invin timer"


func _physics_process(delta):
	deal_with_damage()
	
	if player_chase:
		position += (player.position - position) * speed * delta
	
	animated_sprite_2d.play("run")
	
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
		player_hittable = true


func _on_hitbox_body_exited(body):
	if body.has_method("player"):
		player_hittable = false


func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			invin_timer.start()
			can_take_damage = false
			print("gumball health =", health)
			if health <= 0:
				self.queue_free()


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
