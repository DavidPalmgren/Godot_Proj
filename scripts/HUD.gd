extends Control
signal lose

# Called when the node enters the scene tree for the first time.
func _ready():
	$ProgressBar.value = 100

func take_damage():
	if $ProgressBar.value > 0:
		$ProgressBar.value -= 1
	else:
		lose.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
 
