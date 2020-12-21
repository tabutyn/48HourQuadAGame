extends Node2D

const enemy = preload("res://Enemy.tscn")
const shark = preload("res://shark.tscn")
const skull = preload("res://skull.tscn")


var score = 100




func update_interface() -> void:
	$"UI/User Interface/Scoreboard".text = "Score: %s" % int(score)
	

	
	

var enemies = []
var shark_height = 360
var max_health = 4
var current_health = max_health

func _ready():
	for i in range(100):
		if randf() > 0.5:
			enemies.append(enemy.instance())
		else:
			enemies.append(skull.instance())
		enemies[enemies.size() - 1].position.y = shark_height
		enemies[enemies.size() - 1].position.x = (400 + randf()*100) * i
		enemies[enemies.size() - 1].scale = Vector2(2.0, 2.0)
		add_child(enemies[enemies.size() - 1])

func _on_skull_overlap(body):
	current_health -= 1
	print(current_health)

	
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
	
	


