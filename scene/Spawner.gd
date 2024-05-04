extends Area2D
@export var mob_scene: PackedScene
signal spawned

func spawn():
	randomize()
	var mob = mob_scene.instantiate()
	mob.position.x = position.x + lerp(-50, 50, randf())
	mob.position.y = position.y + lerp(-50, 50, randf())
	get_parent().add_child(mob)
	spawned.emit()
	return mob

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
