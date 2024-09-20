extends CharacterBody2D

var speed = 0.4
var player_chase = false
var player = null
var player_hittable = true
var health = 30
var about_to_attack = false
var attack_zone = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var Player = $Player
@onready var attack_animation = $"Attack animation"
@onready var audio_stomping = $"../AudioStomping"




func _physics_process(delta):

	if player_chase:
		position += (player.position - position) * speed * delta
		if (player.position.x - position.x) > 0:
			animated_sprite.flip_h = false
			animated_sprite.play("run")
		if (player.position.x - position.x) < 0:
			animated_sprite.flip_h = true
			animated_sprite.play("run")
			audio_stomping.play
		
	if about_to_attack:
		position += (player.position - position) * speed * delta
		audio_stomping.stop
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
		about_to_attack = true
		attack_animation.start()
		player_chase = false


func _on_hitbox_body_exited(body):
	if body.has_method("player"):
		attack_zone = false
		about_to_attack = false
		player_chase = true


func enemy():
	pass



func _on_attack_animation_timeout():
	if about_to_attack == true:
		attack_zone = true
