extends CharacterBody2D

var SPEED = 100
var PLAYER_STATE
var LAST_DIRECTION
var PLAYER_ID

func _ready():
	PLAYER_ID = get_instance_id()

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

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
			spawned.emit()
			$AnimatedSprite2D.play("walk_up")
		elif  dir.x == 1:
			$AnimatedSprite2D.play("walk_right")
		elif  dir.y == 1:
			$AnimatedSprite2D.play("walk_down")
		elif  dir.x == -1:
			$AnimatedSprite2D.play("walk_left")
