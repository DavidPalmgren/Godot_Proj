extends Node2D

@export var noise_height_text : NoiseTexture2D
var noise : Noise
@onready var tile_map = $TileMap

var source_id = 0  # Adjusted source_id to 1 (presuming this is the index of the tileset)
var water_atlas = Vector2i(1, 1)
var land_atlas = Vector2i(2, 2)

const GRID_WIDTH: int = 10
const GRID_HEIGHT: int = 10

func _ready():
	noise = noise_height_text.noise
	generate_world()

func generate_world():
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			var noise_val = noise.get_noise_2d(x, y)
			print(noise_val)
			if noise_val >= 0.0:
				tile_map.set_cell(1, Vector2i(x, y), source_id, land_atlas)
			else:
				tile_map.set_cell(1, Vector2i(x, y), source_id, water_atlas)
