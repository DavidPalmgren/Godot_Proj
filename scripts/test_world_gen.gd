extends Node2D
@onready var tilemap = $TileMap

const MAP_SIZE = Vector2(100,100)
const LAND_CAP = 0.3
const cell_size = 16
const WALL_TILE_INDEX = Vector2(4,5)

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

func place_building_block(position: Vector2):
	var tile_mouse_pos = tilemap.local_to_map(position)
	print('place wall block pos: ', tile_mouse_pos)
	tilemap.set_cell(0, tile_mouse_pos, 0, WALL_TILE_INDEX)

func snap_to_grid(position: Vector2) -> Vector2:
	return Vector2(
		round(position.x / cell_size) * cell_size,
		round(position.y / cell_size) * cell_size
	)
