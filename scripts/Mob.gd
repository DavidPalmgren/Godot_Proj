extends RigidBody2D
@export var mob_scene: PackedScene
# Called when the node enters the scene tree for the first time.
<<<<<<< HEAD
var target_player
=======
var player: Node = null
>>>>>>> 9910a499cb9f6fd824898a618e41525c0c576559

func _ready():
	var mob = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob[4])

func set_target_player(player):
	target_player = player
	print('yell my target is player ' + str(target_player.PLAYER_ID))

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _set_player(player_ref: Node):
	player = player_ref

func _process(_delta):
	if player:
		print('player exists')

func _on_body_entered(body:Node):
	print(body, " entered")

func _on_body_exited(body:Node):
	print(body, " exited")
