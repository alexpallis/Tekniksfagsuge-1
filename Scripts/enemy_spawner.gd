extends Node2D

class_name Enemyspawner

var coins = 0
var kills = 0

@onready var coin_label = $CoinLabel
@onready var tilemap = $"../RandomDungeon"
@onready var spawned_enemies = $SpawnedEnemies
@onready var spawned_coins = $SpawnedCoins
@onready var game_manager = $"../GameManager"
@onready var random_dungeon = $"../RandomDungeon"
@onready var level_2 = $Level2
@onready var stage_2_maker = $"../Stage2Maker"
@onready var boss_fight = $BossFight


var max_benemies = 5 + Generator.level * 5
var benemy_count = 0 
var max_genemies = 7 + Generator.level * 4
var genemy_count = 0
var ghost_count = 0
var max_ghost = 3 + Generator.level * 3
var rng = RandomNumberGenerator.new()
var coin_count = 0
var max_coins = 25
var player_count = 0
var only_one_please = 1
var attempts = 0



func _ready():
	if Generator.level == 0:
		var used_cells = tilemap.get_used_cells(0)
		var attempts = 0
		var spawned = false
		var cell_coords = Vector2(position.x, position.y)
		while player_count < only_one_please:
			var random_position = Vector2(rng.randi() % tilemap.get_used_rect().size.x,rng.randi() % tilemap.get_used_rect().size.y)
			var spawnable = tilemap.get_cell_source_id(0,random_position)
			if spawnable == 0:
				var player = global.player_scene.instantiate()
				player.position = tilemap.map_to_local(random_position) + Vector2(96, 96) / 2
				random_dungeon.add_child(player)
				player_count += 1
	
		while benemy_count < max_benemies:
			var random_position = Vector2(rng.randi() % tilemap.get_used_rect().size.x,rng.randi() % tilemap.get_used_rect().size.y)
			var spawnable = tilemap.get_cell_source_id(0,random_position)
			if spawnable == 0:
				var enemyb = global.bjørn_scene.instantiate()
				enemyb.position = tilemap.map_to_local(random_position) + Vector2(96, 96) / 2
				spawned_enemies.add_child(enemyb)
				benemy_count += 1
			
			else:
				attempts += 1
		while coin_count < max_coins:
			var random_position = Vector2(rng.randi() % tilemap.get_used_rect().size.x,rng.randi() % tilemap.get_used_rect().size.y)
			var spawnable = tilemap.get_cell_source_id(0,random_position)
			if spawnable == 0:
				var coins = global.coin_scene.instantiate()
				coins.position = tilemap.map_to_local(random_position) + Vector2(96, 96) / 2
				spawned_coins.add_child(coins)
				coin_count += 1
			
			else:
				attempts += 1
			
		while genemy_count < max_genemies:
			var random_position = Vector2(rng.randi() % tilemap.get_used_rect().size.x,rng.randi() % tilemap.get_used_rect().size.y)
			var spawnable = tilemap.get_cell_source_id(0,random_position)
			if spawnable == 0:
				var enemyg = global.gumball_scene.instantiate()
				enemyg.position = tilemap.map_to_local(random_position) + Vector2(96, 96) / 2
				spawned_enemies.add_child(enemyg)
				genemy_count += 1
			
		while ghost_count < max_ghost:
			var random_position = Vector2(rng.randi() % tilemap.get_used_rect().size.x,rng.randi() % tilemap.get_used_rect().size.y)
			var spawnable = tilemap.get_cell_source_id(0,random_position)
			if spawnable == 0:
				var ghost = global.ghost_scene.instantiate()
				ghost.position = tilemap.map_to_local(random_position) + Vector2(96, 96) / 2
				spawned_enemies.add_child(ghost)
				ghost_count += 1


	if Generator.level == 1:
		var used_cells = stage_2_maker.get_used_cells(0)
		var attempts = 0
		var spawned = false
		var cell_coords = Vector2(position.x, position.y)
		while player_count < only_one_please:
			var random_position = Vector2(rng.randi() % stage_2_maker.get_used_rect().size.x,rng.randi() % stage_2_maker.get_used_rect().size.y)
			var spawnable = stage_2_maker.get_cell_source_id(0,random_position)
			if spawnable == 0:
				var player = global.player_scene.instantiate()
				player.position = stage_2_maker.map_to_local(random_position) + Vector2(96, 96) / 2
				stage_2_maker.add_child(player)
				player_count += 1
	
		while benemy_count < max_benemies:
			var random_position = Vector2(rng.randi() % stage_2_maker.get_used_rect().size.x,rng.randi() % stage_2_maker.get_used_rect().size.y)
			var spawnable = stage_2_maker.get_cell_source_id(0,random_position)
			if spawnable == 0:
				var enemyb = global.bjørn_scene.instantiate()
				enemyb.position = stage_2_maker.map_to_local(random_position) + Vector2(96, 96) / 2
				spawned_enemies.add_child(enemyb)
				benemy_count += 1
			
			else:
				attempts += 1
		while coin_count < max_coins:
			var random_position = Vector2(rng.randi() % stage_2_maker.get_used_rect().size.x,rng.randi() % stage_2_maker.get_used_rect().size.y)
			var spawnable = stage_2_maker.get_cell_source_id(0,random_position)
			if spawnable == 0:
				var coins = global.coin_scene.instantiate()
				coins.position = stage_2_maker.map_to_local(random_position) + Vector2(96, 96) / 2
				spawned_coins.add_child(coins)
				coin_count += 1
			
			else:
				attempts += 1
			
		while genemy_count < max_genemies:
			var random_position = Vector2(rng.randi() % stage_2_maker.get_used_rect().size.x,rng.randi() % stage_2_maker.get_used_rect().size.y)
			var spawnable = stage_2_maker.get_cell_source_id(0,random_position)
			if spawnable == 0:
				var enemyg = global.gumball_scene.instantiate()
				enemyg.position = stage_2_maker.map_to_local(random_position) + Vector2(96, 96) / 2
				spawned_enemies.add_child(enemyg)
				genemy_count += 1
			
		while ghost_count < max_ghost:
			var random_position = Vector2(rng.randi() % stage_2_maker.get_used_rect().size.x,rng.randi() % stage_2_maker.get_used_rect().size.y)
			var spawnable = stage_2_maker.get_cell_source_id(0,random_position)
			if spawnable == 0:
				var ghost = global.ghost_scene.instantiate()
				ghost.position = stage_2_maker.map_to_local(random_position) + Vector2(96, 96) / 2
				spawned_enemies.add_child(ghost)
				ghost_count += 1



func _on_spawned_coins_child_exiting_tree(node):
	coins += 1
	

func _process(delta):
	if coins == 2 and Generator.level == 0:
		Generator.level = 1
		get_tree().change_scene_to_file("res://Scens/level_2.tscn")
	if coins == 20 and Generator.level == 1:
		Generator.level = 2
		get_tree().change_scene_to_file("res://Scens/BOSS FIGHT.tscn")



#score stuff

var score = 0

func add_dream_point():
	score += 1
	print(score)
	


func _on_level_2_timeout():
	get_tree().change_scene_to_file("res://level_2.tscn")
