extends TileMap

@export var noise_height_text : NoiseTexture2D
var noise : Noise
@onready var tile_map = $TileMap

var source_id = 0
var water_atlas = Vector2i(50, 5)
var land_atlas = Vector2i(0, 0)

const GRID_WIDTH:int = 100
const GRID_HEIGHT:int = 100

func _ready():
	noise = noise_height_text.noise
	
func generate_world():
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			var noise_val = noise.get_noise_2d(x,y)
			print(noise_val)
			if noise_val > 0.0:
				tile_map.set_cell(0, Vector2(x,y), source_id, land_atlas)
				pass
			elif noise_val < 0.0:
				tile_map.set_cell(0, Vector2(x,y), source_id, water_atlas)
				pass
