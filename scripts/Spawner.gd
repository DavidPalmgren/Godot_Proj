extends Area2D
@export var mob_scene: PackedScene = preload("res://scene/Mob.tscn")
signal spawned

var players: Array = []

func _ready():
	print('mounted spawner')
	for node in get_tree().get_nodes_in_group("players"):
		print("player")
		print(node)
		players.append(node)

func spawn():
	if players.size() > 0:
		randomize()
		var random_player = players[randi() % players.size()]
		print(random_player)
		var mob = mob_scene.instance()
		mob.position.x = position.x + lerp(-50, 50, randf())
		mob.position.y = position.y + lerp(-50, 50, randf())
		random_player.add_child(mob)
		spawned.emit()
		return mob
	else:
		print("No players available to assign zombies to.")
		return null

func _process(_delta):
	pass

func _on_start_timer_timeout():
	pass # Replace with function body.

func _on_mob_timer_timeout():
	pass # Replace with function body.
