extends CharacterBody2D

class_name Player

const SPEED = 150
const DASH_SPEED = 500
var dashing = false 
var enemy_attack_range = false
var enemy_attack_cooldown =true
var health = 100
var player_alive = true
var dash_cooldown = true
var slash_cooldown = true
var attack_ip = false

#healthbar related
#signal healthChanged

@onready var dash_cooldown_timer = $"dash cooldown timer"
@onready var dash_timer = $"dash timer"
@onready var animated_sprite = $AnimatedSprite
@onready var attack_cooldown = $"attack cooldown"
@onready var dael_attack_timer = $"dael attack timer"
@onready var attack_noise = $"Attack noise"
@onready var dash_noise = $"Dash noise"
@onready var slash_cooldown_timer = $"Slash cooldown timer"
@onready var currentHealth: int = health





func _physics_process(_delta):
	dash()
	enermy_attack()
	update_health()
	
	if health <= 0:
		player_alive = false # tlføj game over
		health = 0
		print("player has been killed")
		get_tree().change_scene_to_file("res://game_over.tscn") #dette er game over
	
	
	var direction = Input.get_vector("move left","move right","move up","move down")
	
	if direction:
		if dashing and attack_ip == false:
			velocity.x = direction.x * DASH_SPEED
			velocity.y = direction.y * DASH_SPEED
			
			if direction.x < 0 and direction.y == 0:
				animated_sprite.flip_h = true
				animated_sprite.play("dash left right")
	
			if direction.x > 0 and direction.y == 0:
				animated_sprite.flip_h = false
				animated_sprite.play("dash left right")
	
			if direction.y < 0:
				animated_sprite.play("dash up")
	
			if direction.y > 0:
				animated_sprite.play("dash down")
		else:
			velocity.x = direction.x * SPEED
			velocity.y = direction.y * SPEED
			if attack_ip == false:
				if direction.x < 0 and direction.y == 0:
					animated_sprite.flip_h = true
					animated_sprite.play("walk left right")
	
				if direction.x > 0 and direction.y == 0:
					animated_sprite.flip_h = false
					animated_sprite.play("walk left right")
	
				if direction.y < 0:
					animated_sprite.play("walk up")
	
				if direction.y > 0:
					animated_sprite.play("walk down")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if Input.is_action_pressed("attack") and slash_cooldown == true:
		attack_noise.play()
		slash_cooldown = false
		slash_cooldown_timer.start()
		if direction.y < 0:
			animated_sprite.play("attack up")
		if direction.y > 0:
			animated_sprite.play("attack down")
		if direction.x < 0 and direction.y == 0:
			animated_sprite.flip_h = true
			animated_sprite.play("attack left right")
		if direction.x > 0 and direction.y == 0:
			animated_sprite.flip_h = false
			animated_sprite.play("attack left right")
		if direction.x == 0 and direction.y == 0:
			animated_sprite.play("attack down")
		
		global.player_current_attack = true
		attack_ip = true
		dael_attack_timer.start()
	
	if direction.y == 0 and direction.x == 0 and attack_ip == false:
		
		if Input.is_action_just_released("move left") or Input.is_action_just_released("move right"):
			animated_sprite.play("idl left right")
	
		if Input.is_action_just_released("move down"):
			animated_sprite.play("idl down")
	
		if Input.is_action_just_released("move up"):
			animated_sprite.play("idl up")
		
		if Input.is_action_pressed("move down") and Input.is_action_pressed("move up") or Input.is_action_pressed("move left") and Input.is_action_pressed("move right"):
			animated_sprite.play("dance")
	
	move_and_slide()

func dash():
	if Input.is_action_just_pressed("Dash") and dash_cooldown == true:
		dash_noise.play()
		dashing = true
		dash_timer.start()
		dash_cooldown_timer.start()
		dash_cooldown = false

func _on_dash_timer_timeout():
	dashing = false

func _on_dash_cooldown_timeout():
	dash_cooldown = true

func  player():
	pass

func taget():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_attack_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_attack_range = false

func enermy_attack():
	if enemy_attack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		attack_cooldown.start()
		print(health)
		#healthChanged.emit()

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func _on_dael_attack_timer_timeout():
	global.player_current_attack = false
	attack_ip = false


func _on_slash_cooldown_timer_timeout():
	slash_cooldown = true


#healthbar related
func update_health():
	var healthbar = $Camera2D/healthBar_canvas/Health_BAr
	healthbar.value = health
	set_health_label()
	set_dreams_label()
	
	
func set_health_label():
	$Camera2D/healthBar_canvas/Label.text = "hp: %s" % health

func  set_dreams_label():
	$Camera2D/healthBar_canvas/Dreams.text = "Dreams collected" + coins
