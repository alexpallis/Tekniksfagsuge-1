extends CharacterBody2D

const SPEED = 200
const DASH_SPEED = 700
var dashing = false 

@onready var dash_cooldown = $"dash cooldown"
@onready var dash_timer = $"dash timer"
@onready var animated_sprite = $AnimatedSprite

func _physics_process(delta):
	
	var direction = Input.get_vector("move left","move right","move up","move down")
	
	if direction:
		if dashing:
			velocity.x = direction.x * DASH_SPEED
			velocity.y = direction.y * DASH_SPEED
		else:
			velocity.x = direction.x * SPEED
			velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	#Animation
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
	
	if direction.y == 0 and direction.x == 0:
		
		if Input.is_action_just_released("move left") or Input.is_action_just_released("move right"):
			animated_sprite.play("idl left right")
	
		if Input.is_action_just_released("move down"):
			animated_sprite.play("idl down")
	
		if Input.is_action_just_released("move up"):
			animated_sprite.play("idl up")
		
		if Input.is_action_pressed("move down") and Input.is_action_pressed("move up") or Input.is_action_pressed("move left") and Input.is_action_pressed("move right"):
			animated_sprite.play("idl down")
	
	if (sqrt(velocity.x*velocity.x)) > SPEED:
		animated_sprite.play("Dash")
	elif (sqrt(velocity.y*velocity.y)) > SPEED:
		animated_sprite.play("Dash")
		
	if Input.is_action_just_pressed("Dash"):
		dashing = true
		dash_timer.start()
	move_and_slide()

func _on_dash_timer_timeout():
	dashing = false
	dash_cooldown.start()

func _on_dash_cooldown_timeout():
	pass
