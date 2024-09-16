extends CharacterBody2D

const SPEED = 100.0

@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	
	var direction = Input.get_vector("move left","move right","move up","move down")
	
	if direction.x > 0:
		animated_sprite.flip_h = false
		animated_sprite.play("walk left right")
	elif direction.x < 0:
		animated_sprite.flip_h = true
		animated_sprite.play("walk left right")
	if direction.x == 0:
		animated_sprite.play("idl down")
	
	if direction.y > 0:
		animated_sprite.play("walk down")
	elif direction.y < 0:
		animated_sprite.play("walk up")
		
	if direction.x:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction.y:
		velocity.y = direction.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
