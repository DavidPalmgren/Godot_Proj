extends Node2D

@export var healthComponent: HealthComponent
@export var MAX_HEALTH:= 100
var health : float

func _ready():
	health = MAX_HEALTH
	pass

