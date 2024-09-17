extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var dash_timer: Timer = $dash_timer

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
const DASH_SPEED = 700.0
var dashing = false
var updown = false
var downup = false
func _physics_process(delta: float) -> void:
	# Add the gravity.
	

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("Dash"):
		dashing = true
		dash_timer.start()
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
	
	if Input.is_action_just_released("MoveUp"):
		updown = true
		downup = false
	if Input.is_action_just_pressed("MoveRight"):
		updown = false
		downup= false
	if Input.is_action_just_pressed("MoveLeft"):
		updown = false
		downup = false
	if Input.is_action_just_pressed("MoveDown"):
		updown = false
		downup = true
		
	if Input.is_action_pressed("MoveRight"):
		updown = false
		downup= false
	if Input.is_action_pressed("MoveLeft"):
		updown = false
		downup= false
		
	if (sqrt(velocity.x*velocity.x)) > SPEED:
		animated_sprite.play("Dash")
	elif (sqrt(velocity.y*velocity.y)) > SPEED:
		animated_sprite.play("Dash")
	elif direction.y > 0:
		animated_sprite.play("down")
	elif direction.y < 0:
		animated_sprite.play("up")
	elif updown:
		animated_sprite.play("back")
	elif downup:
		animated_sprite.play("front")
	elif direction.x == 0:
		animated_sprite.play("Idle")
		
		
	
	elif sqrt(direction.x * direction.x) > 0 :
		animated_sprite.play("run")
	
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

	move_and_slide()

#no more dashing
func _on_dash_timer_timeout() -> void:
	dashing = false
