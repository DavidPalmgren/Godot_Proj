extends CharacterBody2D

var SPEED: int = 100
var HEALTH: int = 100
var PLAYER_STATE: String
var LAST_DIRECTION
var PLAYER_ID
var GRID_SIZE

var BUILD_MODE_ACTIVE = false
var TILE_MAP: Node2D #Ye this is the node2d parent of the tilemap :x
var BUILDING: PackedScene
var preview_building
var building_offset

func _ready():
	PLAYER_ID = get_instance_id()

func set_tilemap_ref(tilemap_ref: Node2D):
	TILE_MAP = tilemap_ref
	GRID_SIZE = TILE_MAP.cell_size
	print('grid size is', GRID_SIZE)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func round_to_nearest_grid(value):
	return round(value / GRID_SIZE) * GRID_SIZE

# Snap a position to the grid
func snap_to_grid(position):
	return Vector2(round_to_nearest_grid(position.x), round_to_nearest_grid(position.y))


func _input(event):
	if BUILDING and BUILD_MODE_ACTIVE:
		if event.is_action_pressed("ui_cancel"):
			exit_build_mode()
		elif event is InputEventMouseMotion:
			set_preview_building_position()
		elif event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				var mouse_pos = get_global_mouse_position()
				print("placing the sucker")
				var bulding_instance = BUILDING.instantiate()
				var snapped_position = snap_to_grid(mouse_pos)
				bulding_instance.global_position = snapped_position
				get_parent().add_child(bulding_instance)

				#TILE_MAP.place_building_block(mouse_pos)
				#exit_build_mode()
			elif event.button_index == MOUSE_BUTTON_RIGHT and not event.pressed:
				exit_build_mode()

func enter_build_mode(building_item: String):
	BUILD_MODE_ACTIVE = true
	BUILDING = get_building(building_item)
	$Cursor.change_cursor("hand")

	# Create a preview of the building
	preview_building = load("res://scene/GenericComponents/BuildingPreview.tscn").instantiate()
	add_child(preview_building)

	# Store the offset between the cursor position and the building position
	building_offset = Vector2.ZERO

	# Set the preview building's position to follow the cursor
	set_preview_building_position()

func exit_build_mode():
	BUILD_MODE_ACTIVE = false
	BUILDING = null
	
	$Cursor.change_cursor("none")
	print("Exiting build mode")
	if preview_building != null:
		preview_building.queue_free()
		preview_building = null

func get_building(building_ref):
	var building
	if building_ref == "wall":
		var wall_scene = load("res://scene/Buildings/Wall_Barricade01.tscn")
		building = wall_scene
	return building

func set_preview_building_position():
	if preview_building != null:
		var cursor_position = get_global_mouse_position()
		var snapped_position = snap_to_grid(cursor_position)
		preview_building.global_position = snapped_position - building_offset

func place_building(position):
	if BUILD_MODE_ACTIVE:
		if is_valid_building_position(position):
			print("Placing building at position:", position)
			TILE_MAP.place_wall_block(position)
			exit_build_mode()
		else:
			print("Invalid building position")

func is_valid_building_position(pos):
	return true

func _physics_process(_delta):
	var direction = Input.get_vector('move_left','move_right','move_up','move_down')
	if direction.x == 0 and direction.y == 0:
		PLAYER_STATE = 'idle'
	elif direction.x != 0 or direction.y != 0:
		PLAYER_STATE = 'walk'
		LAST_DIRECTION = direction
	velocity = direction * SPEED
	move_and_slide()
	for index in get_slide_collision_count():
		var collision := get_slide_collision(index)
		var body := collision.get_collider()
		$HealthBar.take_damage()
		print("Collided with: ", body.name)
	play_anim(direction, LAST_DIRECTION)
	
func play_anim(dir, last_dir):
	if PLAYER_STATE == 'idle':
		if !last_dir:
			$AnimatedSprite2D.play("idle_down")
		elif last_dir.y == -1:
			$AnimatedSprite2D.play("idle_up")
		elif  last_dir.x == 1:
			$AnimatedSprite2D.play("idle_right")
		elif  last_dir.y == 1:
			$AnimatedSprite2D.play("idle_down")
		elif  last_dir.x == -1:
			$AnimatedSprite2D.play("idle_left")
	elif PLAYER_STATE == 'walk':
		if dir.y == -1:
			$AnimatedSprite2D.play("walk_up")
		elif  dir.x == 1:
			$AnimatedSprite2D.play("walk_right")
		elif  dir.y == 1:
			$AnimatedSprite2D.play("walk_down")
		elif  dir.x == -1:
			$AnimatedSprite2D.play("walk_left")
