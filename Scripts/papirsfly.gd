extends CharacterBody2D

const  SPEED = 1
var player_chase = false
var player = null
const knock_back_SPEED = 150
var life_timer = true

var health = 1
var player_inattack_zone = false
var can_take_damage = true


@onready var animated_sprite = $AnimatedSprite2D
@onready var life_timer_timer = $"Life Timer Timer"



func _ready():
	if life_timer == true:
		life_timer_timer.start()
		life_timer = false

func _physics_process(delta):
	deal_with_damage()

	if player_chase:
		position += (player.position - position) * SPEED * delta
		look_at(player.position)
		#position += (player.position - position)/(sqrt((player.position - position)*(player.position - position))) * SPEED
	if Generator.level == 1 or Generator.level == 2:
		move_and_slide()

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


func _on_papirsfly_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true

func _on_papirsfly_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			print("papirsfly health =", health)
			if health <= 0:
				self.queue_free()

	

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


func _on_life_timer_timer_timeout():
	self.queue_free()
	print("hi %d" % [Time.get_time_dict_from_system().second])
