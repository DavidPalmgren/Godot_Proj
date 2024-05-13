extends Node2D
class_name HealthComponent

@export var progressBar: ProgressBar
@export var MAX_HEALTH := 100
var health : float

func _ready():
	#progressBar = $HealthComponent/HealthBar
	print('health comp loaded')
	health = MAX_HEALTH

func set_health(healthPercent: float) -> void:
	progressBar.value = healthPercent * progressBar.max_value

func damage(attack):
	health -= attack
	if health <= 0:
		print('Unit pepsid')
		get_parent().queue_free()
