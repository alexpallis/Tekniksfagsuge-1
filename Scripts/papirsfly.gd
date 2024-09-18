extends CharacterBody2D

const  SPEED = 100
var player_chase = false
var player = null
const knock_back_SPEED = 150

var health = 1
var player_inattack_zone = false
var can_take_damage = true
@onready var animated_sprite = $AnimatedSprite2D



func _physics_process(delta):
	deal_with_damage()
	
	if player_chase:
		position += (player.position - position)/SPEED
		#position += (player.position - position)/(sqrt((player.position - position)*(player.position - position))) * SPEED

		if(player.position.x - position.x) < 0:
			animated_sprite.flip_h = true
			animated_sprite.play("fly left right")
		
		if(player.position.x - position.x) > 0:
			animated_sprite.flip_h = false
			animated_sprite.play("fly left right")
		
		if(player.position.y - position.y) < 0 and (player.position.x - position.x) == 0:
			animated_sprite.flip_v = false
			animated_sprite.play("fly up down")
		
		if(player.position.y - position.y) > 0 and (player.position.x - position.x) == 0:
			animated_sprite.flip_v = true
			animated_sprite.play("fly up down")
	

func _on_detection_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true

func _on_detection_body_exited(body):
	if body.has_method("player"):
		player = null
	player_chase = false

func enemy():
	pass


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
			can_take_damage = false
			print("ghost health =", health)
			if health <= 0:
				self.queue_free()
	
	move_and_slide()





func _on_papirsly_hitbox_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true

func _on_papirsly_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false


func _on_dead_area_body_entered(body):
	if body.has_method("taget"):
		self.queue_free()
