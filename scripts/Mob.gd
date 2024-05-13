extends Area2D
@export var mob_scene: PackedScene
@onready var nav : NavigationAgent2D = $NavigationAgent2D
var finished = false
var target_player
var speed = 100
var attack_damage := 10   

func _ready():
	var mob = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob[4])
	set_physics_process(false)
	call_deferred('setup')

func set_target_player(player):
	target_player = player
	print('yell my target is player ' + str(target_player.PLAYER_ID))

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _set_player(player_ref: Node):
	target_player = player_ref
	await get_tree().physics_frame
	set_physics_process(true)
	nav.target_position = target_player.global_position

func setup():
	pass


func _physics_process(delta):
	if not finished:
		nav.target_position = target_player.global_position
		var direction = (nav.get_next_path_position() - global_position).normalized()
		translate(direction*speed*delta)

func _on_navigation_agent_2d_navigation_finished():
	finished = true

func _on_body_entered(_body:Node2D):
	$HitTimer.start()

func _on_body_exited(_body:Node2D):
	$HitTimer.stop()

func _on_hit_timer_timeout():
	SignalBus.emit_signal("on_hit")
func _on_hitbox_area_entered(area):
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		var dmg = attack_damage
		print('Die bitch')
		hitbox.damage(dmg)
