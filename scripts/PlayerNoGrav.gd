extends CharacterBody2D

var SPEED: int = 100
var HEALTH: int = 100
var PLAYER_STATE: String
var LAST_DIRECTION
var PLAYER_ID
var BUILD_MODE_ACTIVE = false
var TILE_MAP: Node2D #Ye this is the node2d parent of the tilemap :x
var BUILDING

func _ready():
	PLAYER_ID = get_instance_id()

func set_tilemap_ref(tilemap_ref: Node2D):
	TILE_MAP = tilemap_ref

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			var mouse_pos = get_global_mouse_position()
			TILE_MAP.place_building_block(mouse_pos)

func enter_build_mode(position:Vector2, building_item: String): #building, pos:int
	BUILD_MODE_ACTIVE = true
	BUILDING = get_building(building_item)
	$Cursor.change_cursor("hand")
	print("Entering build mode")

func exit_build_mode():
	BUILD_MODE_ACTIVE = false
	BUILDING = ""
	
	$Cursor.change_cursor("none")
	print("Exiting build mode")

func get_building(building_ref):
	var building
	if building_ref == "wall":
		building = "some prefab"
	return building

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
			$AnimatedSprite2D.play("idle_down")
		elif  last_dir.x == 1:
			$AnimatedSprite2D.play("idle_right")
		elif  last_dir.y == 1:
			$AnimatedSprite2D.play("idle_down")
		elif  last_dir.x == -1:
			$AnimatedSprite2D.play("idle_left")
		else:
			print('error')
	elif PLAYER_STATE == 'walk':
		if dir.y == -1:
			$AnimatedSprite2D.play("walk_up")
		elif  dir.x == 1:
			$AnimatedSprite2D.play("walk_right")
		elif  dir.y == 1:
			$AnimatedSprite2D.play("walk_down")
		elif  dir.x == -1:
			$AnimatedSprite2D.play("walk_left")
