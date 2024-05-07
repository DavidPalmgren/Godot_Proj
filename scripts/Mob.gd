extends RigidBody2D
@export var mob_scene: PackedScene
# Called when the node enters the scene tree for the first time.

func _ready():
	var mob = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob[4])
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_body_entered(body:Node):
	print(body, " entered")

func _on_body_exited(body:Node):
	print(body, " exited")
