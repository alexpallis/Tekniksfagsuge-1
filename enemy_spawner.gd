extends Node2D


@onready var spawned_enemies = $SpawnedEnemies
@onready var tilemap = $"../RandomDungeon"


@export var max_enemies = 20 
var enemy_count = 0 
var rng = RandomNumberGenerator.new()


func _ready():
	var used_cells = tilemap.get_used_cells(0)
	var attempts = 0
	var spawned = false
	var cell_coords = Vector2(position.x, position.y)
	
	while enemy_count < max_enemies:
		var random_position = Vector2(rng.randi() % tilemap.get_used_rect().size.x,rng.randi() % tilemap.get_used_rect().size.y)
		var spawnable = tilemap.get_cell_source_id(0,random_position)
		if spawnable == 0:
			print(spawnable)
			var enemyb = global.bjørn_scene.instantiate()
			enemyb.position = tilemap.map_to_local(random_position) + Vector2(16, 16) / 2
			spawned_enemies.add_child(enemyb)
			enemy_count += 1
			
		else:
			attempts += 1
	
