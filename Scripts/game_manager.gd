extends Node

var coins = 0
var kills = 0
var health = 3
var level = 0
@onready var coin_label = $CoinLabel


func  add_coin():
	coins += 1
	coin_label.text = str(coins) + "Coins"

func  lose_health():
	health -= 1
	if health < 1:
		get_tree().reload_current_scene()
	print(health)
	
func gain_health():
	health += 1
