extends TileMap

const GRID_WIDTH = 10
const GRID_HEIGHT = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			set_cell(1,Vector2i(x, y), 1)
			print("cell set at" + str(x) + str(y))
