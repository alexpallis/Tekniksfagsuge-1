extends CharacterBody2D

const  SPEED = 150
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/SPEED
	

func _on_detection_body_entered(body):
	player = body
	player_chase = true

func _on_detection_body_exited(body):
	player = null
	player_chase = false
