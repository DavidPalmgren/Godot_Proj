extends Area2D
@export var mob_scene: PackedScene = preload("res://scene/Mob.tscn")
signal spawned

var players: Array = []

func _ready():
	for node in get_tree().get_nodes_in_group("players"):
		print("player")
		print(node)
		players.append(node)

# spawns and assigns the mobs target
func spawn():
	# Check if there are players available
	if players.size() > 0:
		print("player size over 0")		
		for i in range(0, players.size()):
			randomize()
			var player = players[i]
			#var random_player = players[randi() % players.size()]
			# Spawn the mob and assign it to the chosen player
			var mob = mob_scene.instantiate()
			mob.position.x = position.x + lerp(-50, 50, randf())
			mob.position.y = position.y + lerp(-50, 50, randf())
			mob.set_target_player(player)
			get_parent().add_child(mob) # better if we add a seperate parent node for these rather then spamming them onto the root node
			spawned.emit()
			return mob
	else:
		print("No players available to assign zombies to.")
		return null

#func spawn():
	#randomize()
	#var mob = mob_scene.instantiate()
	#mob.position.x = position.x + lerp(-50, 50, randf())
	#mob.position.y = position.y + lerp(-50, 50, randf())
	#get_parent().add_child(mob)
	#spawned.emit()
	#print("mob spawned")
	#return mob


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_start_timer_timeout():
	pass # Replace with function body.

func _on_mob_timer_timeout():
	pass # Replace with function body.
