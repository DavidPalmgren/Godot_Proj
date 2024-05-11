extends Node2D
@onready var tilemap = $TileMap

const MAP_SIZE = Vector2(100,100)
const LAND_CAP = 0.3
const cell_size = 16
const WALL_TILE_INDEX = Vector2(4,5)

func _ready():
	generate_world()

func _input(event):
	#why does this work because no camera2d obj?
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			var mouse_pos = get_global_mouse_position()
			print('glob mouse' , mouse_pos)
			var tile_mouse_pos = tilemap.local_to_map(mouse_pos)

			tilemap.set_cell(0, tile_mouse_pos, 0, WALL_TILE_INDEX)
			

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

func place_wall_block(position: Vector2):
	# Snap the position to the grid
	
	#var snapped_position = snap_to_grid(position)
	var local_pos = tilemap.local_to_map(position)
	print(local_pos)
	# Set the cell on the TileMap to represent the wall block
	tilemap.set_cell(0, local_pos, 0, WALL_TILE_INDEX)

# Function to snap a position to the nearest grid cell
func snap_to_grid(position: Vector2) -> Vector2:
	return Vector2(
		round(position.x / cell_size) * cell_size,
		round(position.y / cell_size) * cell_size
	)
