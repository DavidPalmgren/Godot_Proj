extends Node2D

const MAP_SIZE = Vector2(100,100)
const LAND_CAP = 0.3
@onready var GUI = $PlayerUI
@onready var PLAYER = $Player
@onready var TILE_MAP = $TestWorldGen

func new_game():
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$WorldTimer.start()
	init_UI()
	init_player()

func init_UI():
	GUI.set_new_round(1)
	GUI.set_new_gold(100)
	GUI.set_new_lumber(100)
	GUI.set_player_ref($Player)
	
func init_player():
	print('sending tile map with')
	print(TILE_MAP)
	PLAYER.set_tilemap_ref(TILE_MAP)

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
