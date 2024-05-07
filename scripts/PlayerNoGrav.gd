extends CharacterBody2D

var speed = 100
var player_state
var last_direction

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _physics_process(_delta):
	var direction = Input.get_vector('move_left','move_right','move_up','move_down')
	if direction.x == 0 and direction.y == 0:
		player_state = 'idle'
	elif direction.x != 0 or direction.y != 0:
		player_state = 'walk'
		last_direction = direction	
	velocity = direction * speed
	move_and_slide()
	for index in get_slide_collision_count():
		var collision := get_slide_collision(index)
		var body := collision.get_collider()
		$HealthBar.take_damage()
		print("Collided with: ", body.name)
	play_anim(direction, last_direction)
	
func play_anim(dir, last_dir):
	if player_state == 'idle':
		if !last_dir:
			$AnimatedSprite2D.play("idle_up")
		elif last_dir.y == -1:
			$AnimatedSprite2D.play("idle_up")
		elif  last_dir.x == 1:
			$AnimatedSprite2D.play("idle_right")
		elif  last_dir.y == 1:
			$AnimatedSprite2D.play("idle_down")
		elif  last_dir.x == -1:
			$AnimatedSprite2D.play("idle_left")
		else:
			print('error')
	elif player_state == 'walk':
		if dir.y == -1:
			$AnimatedSprite2D.play("walk_up")
		elif  dir.x == 1:
			$AnimatedSprite2D.play("walk_right")
		elif  dir.y == 1:
			$AnimatedSprite2D.play("walk_down")
		elif  dir.x == -1:
			$AnimatedSprite2D.play("walk_left")
