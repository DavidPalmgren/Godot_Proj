extends Area2D
@onready var nav : NavigationAgent2D = $NavigationAgent2D
var finished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	call_deferred('setup')
	
func setup():
	await get_tree().physics_frame
	set_physics_process(true)
	nav.target_position = global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not finished:
		var direction = (nav.get_next_path_position() - global_position).normalized()
		translate(direction*200*delta)

func _input(event):
	if event is InputEventMouseButton:
		nav.target_position = get_global_mouse_position()
		finished = false

func _on_navigation_agent_2d_navigation_finished():
	finished = true
