extends TileMap

@export var mapWidth = 64
@export var mapHeight = 64

@export var minRoomSize = 7
@export var maxRoomSize = 9

func _ready():
	Generator.generate(self, mapWidth, mapHeight, minRoomSize, maxRoomSize)
