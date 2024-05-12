extends Node2D

func new_game():
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$WorldTimer.start()

func game_over():
	$MobTimer.stop()

func _on_spawner_spawned():
	$StartTimer.stop()
	$MobTimer.stop()

func _on_start_timer_timeout():
	$MobTimer.start()

func _on_mob_timer_timeout():
	for i in range(0,4):
		$Spawner.spawn()

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_health_bar_lose():
	game_over()
