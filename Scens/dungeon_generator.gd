extends TileMap

@export var mapWidth = 500
@export var mapHeight = 500

@export var minRoomSize = 8
@export var maxRoomSize = 20

func _ready():
	Generator.generate(self, mapWidth, mapHeight, minRoomSize, maxRoomSize)
