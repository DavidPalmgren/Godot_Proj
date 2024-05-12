extends Node2D
@onready var tilemap = get_tree().root.find_child("TileMap", true, false)
var navigation_mesh: NavigationPolygon
var source_geometry : NavigationMeshSourceGeometryData2D
var callback_parsing : Callable
var callback_baking : Callable
var region_rid: RID

const MAP_SIZE = Vector2(100,100)
const LAND_CAP = 0.075

func _ready():
	generate_world()
	navigation_mesh = NavigationPolygon.new()
	navigation_mesh.agent_radius = 10.0
	source_geometry = NavigationMeshSourceGeometryData2D.new()
	callback_parsing = on_parsing_done
	callback_baking = on_baking_done
	region_rid = NavigationServer2D.region_create()
	NavigationServer2D.region_set_enabled(region_rid, true)
	NavigationServer2D.region_set_map(region_rid, get_world_2d().get_navigation_map())
	parse_source_geometry.call_deferred()

func parse_source_geometry() -> void:
	source_geometry.clear()
	var root_node: Node2D = self

	NavigationServer2D.parse_source_geometry_data(
		navigation_mesh,
		source_geometry,
		root_node,
		callback_parsing
	)

func on_parsing_done() -> void:
	source_geometry.add_traversable_outline(PackedVector2Array([
		Vector2(0.0, 0.0),
		Vector2(10000.0, 0.0),
		Vector2(10000.0, 10000.0),
		Vector2(0.0, 10000.0)
	]))

	NavigationServer2D.bake_from_source_geometry_data_async(
		navigation_mesh,
		source_geometry,
		callback_baking
	)

func on_baking_done() -> void:
	NavigationServer2D.region_set_navigation_polygon(region_rid, navigation_mesh)

func generate_world():
	var noise = FastNoiseLite.new()
	noise.noise_type = 1
	var noise2 = FastNoiseLite.new()
	noise2.noise_type = 4
	noise.seed = randi()
	noise2.seed = randi()
	
	var cells = []
	var cells2 = []
	for x in MAP_SIZE.x:
		for y in MAP_SIZE.y:
			var a = noise.get_noise_2d(x,y)
			var b = noise2.get_noise_2d(x,y)

			if a < LAND_CAP and b < LAND_CAP:
				cells.append(Vector2(x,y))
			elif a > LAND_CAP and b < LAND_CAP:
				tilemap.set_cell(0, Vector2(x,y),0, Vector2(3,3))
				cells2.append(Vector2(x,y))
			else:
				tilemap.set_cell(0, Vector2(x,y),0, Vector2(0,5))
				
	tilemap.set_cells_terrain_connect(0, cells, 0, 0)
	#tilemap.set_cells_terrain_connect(0, cells2, 0, 0)

