extends Node

var coins = 0
var kills = 0

@onready var coin_label = $CoinLabel


func add_coin():
	coins += 1
	coin_label.text = str(coins) + "Coins"
	
