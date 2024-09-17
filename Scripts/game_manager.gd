extends Node

var coins = 0
var kills = 0
var health = 3
@onready var coin_label = $CoinLabel


func  add_coin():
	coins += 1
	coin_label.text = str(coins) + "Coins"

func  lose_health():
	health -= 1
	print(health)
	
	
func gain_health():
	health += 1
	
func Game_Over():
	if health < 1:
		get_tree().reload_current_scene()
