extends CharacterBody2D

var speed = 60
var player_chase = false
var player = null
var player_hittable = false
var health = 30
var player_inattack_zone = false
var can_take_damage = true
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $Timer
@onready var Player = $Player


func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed
	
	if player_hittable:
		timer.start()
	animated_sprite_2d.play("run")


func _on_detection_body_entered(body):
	player = body
	player_chase = true


func _on_detection_body_exited(body):
	player = null
	player_chase = false


func _on_hitbox_body_entered(body):
	player_hittable = true


func _on_hitbox_body_exited(body):
	player_hittable = false


func _on_timer_timeout():
	animated_sprite_2d.play("attack")
	if player_hittable:
		Player.health -= 20

func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			can_take_damage = false
			print("gumball health =", health)
			if health <= 0:
				self.queue_free()
