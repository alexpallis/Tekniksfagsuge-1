extends TileMap

@export var mapWidth = 64
@export var mapHeight = 64

@export var minRoomSize = 5
@export var maxRoomSize = 10

func _ready():
	Generator.generate(self, mapWidth, mapHeight, minRoomSize, maxRoomSize)
