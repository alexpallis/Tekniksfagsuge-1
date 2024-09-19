extends CharacterBody2D

enum State {
	None,
	Chase,
	Shoot,
	Flee,
}

const SPEED = 0.25
var state = State.None
var player = null

enum AttackState {
	Cooldown,
	CanShoot,
	Shooting,
}

var attack_state = AttackState.CanShoot

var health = 50
var player_inattack_zone = false
var can_take_damage = true
var papirsfly_shoot = true

@onready var papirer = $Papirer
@onready var animated_sprite = $AnimatedSprite2D
@onready var invin_timer = $"invin timer"
@onready var attack_cooldown_timer = $"attack cooldown timer"
@onready var attack_timer = $"attack timer"
@onready var papirsfly_timer = $"papirsfly timer"

#Hvor skal jeg placere dette kode, kan ikke finde rundt i dette.
#var papir = global.papir_scene.instantiate()
#papir.position = self.position
#papirer.add_child(papir)

func _physics_process(delta):
	if player == null:
		return
		
	deal_with_damage()
	
	#print("hello %d" % [Time.get_time_dict_from_system().second])
	#print(AttackState.find_key(attack_state))

	var d = player.position - position
	
	match state:
		State.Chase:
			position += d * SPEED * delta

			if -d.x < 0 and -d.y == 0:
				animated_sprite.flip_h = true
				animated_sprite.play("walk left right")
			
			if -d.x > 0 and -d.y == 0:
				animated_sprite.flip_h = false
				animated_sprite.play("walk left right")
			
			if -d.y < 0:
				animated_sprite.play("walk up")
			
			if -d.y > 0:
				animated_sprite.play("walk down")
		
		State.Flee:
			position += (position - player.position) * (SPEED / 3) * delta

			if d.x < 0 and d.y == 0:
				animated_sprite.flip_h = true
				animated_sprite.play("walk left right")

			if d.x > 0 and d.y == 0:
				animated_sprite.flip_h = false
				animated_sprite.play("walk left right")

			if d.y < 0:
				animated_sprite.play("walk up")

			if d.y > 0:
				animated_sprite.play("walk down")

		State.Shoot:
			match attack_state:
				AttackState.CanShoot:
					attack_state = AttackState.Shooting
					attack_timer.start()
					attack_cooldown_timer.start()

					
				AttackState.Shooting:
					if -d.x > 0 and -d.y == 0:
						animated_sprite.flip_h = true
						animated_sprite.play("shoot left right")

					if -d.x < 0 and -d.y == 0:
						animated_sprite.flip_h = false
						animated_sprite.play("shoot left right")

					if -d.y > 0:
						animated_sprite.play("shoot up")

					if -d.y < 0:
						animated_sprite.play("shoot down")

				_:
					animated_sprite.play("idl down")
					
		State.None:
			animated_sprite.play("idl down")


	move_and_slide()
func _on_flee_area_body_entered(body):
	if body.has_method("player"):
		state = State.Flee


func _on_flee_area_body_exited(body):
	if body.has_method("player"):
		state = State.Shoot

func _on_attack_area_body_entered(body):
	if body.has_method("player"):
		state = State.Shoot



func _on_attack_area_body_exited(body):
	if body.has_method("player"):
		state = State.Chase



func _on_detection_body_entered(body):
	if body.has_method("player"):
		player = body
		state = State.Chase

func _on_detection_body_exited(body):
	if body.has_method("player"):
		player = null
		state = State.None


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


func _on_attack_timer_timeout():
	attack_state = AttackState.Cooldown
	if papirsfly_shoot == true:
		var papir = global.papir_scene.instantiate()
		papir.position = self.position
		papirer.add_sibling(papir)
		#print("hi %d" % [Time.get_time_dict_from_system().second])
		papirsfly_timer.start()
		papirsfly_shoot = false

func _on_attack_cooldown_timer_timeout():
	attack_state = AttackState.CanShoot


func _on_papirsfly_timer_timeout():
	papirsfly_shoot = true
