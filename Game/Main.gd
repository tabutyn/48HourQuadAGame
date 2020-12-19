extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x_movement = 0.0
	if Input.is_action_pressed("right"):
		x_movement += 1.0
	if Input.is_action_pressed("left"):
		x_movement -= 1.0
	$player.position = Vector2($player.position.x + x_movement, $player.position.y)	
