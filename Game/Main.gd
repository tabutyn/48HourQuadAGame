extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.position = $Player/Player.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print($Player/Player.position)
	var x_camera_player_diff = $Camera2D.position.x - $Player/Player.position.x
	var y_camera_player_diff = $Camera2D.position.y - $Player/Player.position.y
	if x_camera_player_diff >= 50:
		$Camera2D.position.x = $Player/Player.position.x + 50
	if x_camera_player_diff <= -50:
		$Camera2D.position.x = $Player/Player.position.x - 50
	$Camera2D.position.y = $Player/Player.position.y - 50
