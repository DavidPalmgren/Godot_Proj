extends Node2D

var instance_seed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	instance_seed = InstanceSeed.instance_seed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
