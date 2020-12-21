extends Node2D


var score = 100




func update_interface() -> void:
	$"UI/User Interface/Scoreboard".text = "Score: %s" % int(score)
	

	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x_camera_player_diff = $Camera2D.position.x - $Player/Player.position.x
	var y_camera_player_diff = $Camera2D.position.y - $Player/Player.position.y
	if x_camera_player_diff >= 50:
		$Camera2D.position.x = $Player/Player.position.x + 50
	if x_camera_player_diff <= -50:
		$Camera2D.position.x = $Player/Player.position.x - 50
	$Camera2D.position.y = $Player/Player.position.y - 50
	score += delta*2
	update_interface()
	
	
