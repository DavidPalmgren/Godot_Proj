extends Marker2D
@export var mob_scene: PackedScene
signal spawned(spawn)

func spawn():
	var mob = mob_scene.instance()
	add_child(mob)
	mob.setastoplevel(true)
	mob.global_position = global_position
	emit_signal("spawned",mob)
	return mob

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
