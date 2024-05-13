extends Area2D
class_name HitboxComponent

@export var HealthComponent : HealthComponent

func _ready():
	print('hitbox comp loaded')

func damage(attack: float):
	if HealthComponent:
		HealthComponent.take_damage(attack)
