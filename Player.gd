extends Area2D
signal hit

var speed = 100
var player_state
var last_direction

func _on_body_entered(body):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1 * speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1 * speed
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1 * speed
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1 * speed

func _physics_process(delta):
	var direction = Input.get_vector('left','right','up','down')

	if direction.x == 0 and direction.y == 0:
		player_state = 'idle'
	elif direction.x != 0 or direction.y != 0:
		player_state = 'walk'
		last_direction = direction	

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
