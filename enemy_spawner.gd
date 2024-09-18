extends Node2D

var coins = 0
var kills = 0

@onready var coin_label = $CoinLabel


func add_coin():
	coins += 1
	coin_label.text = str(coins) + "Coins"

@onready var spawned_enemies = $SpawnedEnemies
@onready var tilemap = $"../RandomDungeon"
@onready var spawned_coins = $SpawnedCoins



var max_enemies = 20 
var enemy_count = 0 
var rng = RandomNumberGenerator.new()
var coin_count = 0
var max_coins = 20


func _ready():
	var used_cells = tilemap.get_used_cells(0)
	var attempts = 0
	var spawned = false
	var cell_coords = Vector2(position.x, position.y)
	
	while enemy_count < max_enemies:
		var random_position = Vector2(rng.randi() % tilemap.get_used_rect().size.x,rng.randi() % tilemap.get_used_rect().size.y)
		var spawnable = tilemap.get_cell_source_id(0,random_position)
		if spawnable == 0:
			var enemyb = global.bjørn_scene.instantiate()
			enemyb.position = tilemap.map_to_local(random_position) + Vector2(16, 16) / 2
			spawned_enemies.add_child(enemyb)
			enemy_count += 1
			
		else:
			attempts += 1
	while coin_count < max_coins:
		var random_position = Vector2(rng.randi() % tilemap.get_used_rect().size.x,rng.randi() % tilemap.get_used_rect().size.y)
		var spawnable = tilemap.get_cell_source_id(0,random_position)
		if spawnable == 0:
			var coins = global.coin_scene.instantiate()
			coins.position = tilemap.map_to_local(random_position) + Vector2(16, 16) / 2
			spawned_coins.add_child(coins)
			coin_count += 1
			
		else:
			attempts += 1
	
