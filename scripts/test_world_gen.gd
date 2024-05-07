extends Node2D
@export var world_gen: PackedScene = preload("res://scene/test_world_gen.tscn")
@onready var tilemap = $TileMap

const MAP_SIZE = Vector2(100,100)
const LAND_CAP = 0.3

func _ready():
	generate_world()

func generate_world():
	var noise = FastNoiseLite.new()
	noise.seed = randi()
	
	var cells = []
	for x in MAP_SIZE.x:
		for y in MAP_SIZE.y:
			var a = noise.get_noise_2d(x, y)
			if a < LAND_CAP:
				cells.append(Vector2(x,y))
			else:
				tilemap.set_cell(0, Vector2(x,y),0, Vector2(0,5))
				
	tilemap.set_cells_terrain_connect(0, cells, 0, 0)