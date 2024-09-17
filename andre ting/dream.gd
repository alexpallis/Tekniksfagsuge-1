extends Area2D

const SPEED = 50
@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager = %GameManager

func _ready():
	animated_sprite.play("wakeup")

func _physics_process(delta):
	var direction = Input.get_vector("move left","move right","move up","move down")
	
	if direction.x < 0:
		animated_sprite.flip_h = false
		animated_sprite.play("walk left right")
	
	if direction.x > 0:
		animated_sprite.flip_h = true
		animated_sprite.play("walk left right")
	
	if direction.y < 0:
		animated_sprite.play("walk up")
	
	if direction.y > 0:
		animated_sprite.play("walk down")
	
	if Input.is_action_just_released("move left") or Input.is_action_just_released("move right"):
		animated_sprite.play("idl left right")
	
	if Input.is_action_just_released("move down"):
		animated_sprite.play("idl down")
	
	if Input.is_action_just_released("move up"):
		animated_sprite.play("idl up")
