extends Node2D

const enemy = preload("res://Enemy.tscn")
const shark = preload("res://shark.tscn")

var enemies = []
var sharks = []
var shark_height = 380

func _ready():
	for i in range(10):
		enemies.append(enemy.instance())
		enemies[enemies.size() - 1].position.y = shark_height - 200
		enemies[enemies.size() - 1].position.x = (200 + randf()*400) * i
		enemies[enemies.size() - 1].scale = Vector2(1.4, 1.4)
		add_child(enemies[enemies.size() - 1])
	for j in range(10):
		enemies.append(enemy.instance())
		enemies[enemies.size() - 1].position.y = shark_height
		enemies[enemies.size() - 1].position.x = (200 + randf()*400) * j
		enemies[enemies.size() - 1].scale = Vector2(2.2, 2.2)
		add_child(enemies[enemies.size() - 1])
	enemies[0].position.y = shark_height
	add_child(enemies[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x_camera_player_diff = $Camera2D.position.x - $Player/Player.position.x
	var y_camera_player_diff = $Camera2D.position.y - $Player/Player.position.y
	if x_camera_player_diff >= 50:
		$Camera2D.position.x = $Player/Player.position.x + 50
	if x_camera_player_diff <= -50:
		$Camera2D.position.x = $Player/Player.position.x - 50

