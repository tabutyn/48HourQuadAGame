extends Node2D

const enemy = preload("res://Enemy.tscn")
const skull = preload("res://skull.tscn")
const health = preload("res://health.tscn")

var score = 100

func update_interface() -> void:
	$"UI/User Interface/Scoreboard".text = "Score: %s" % int(score)


var enemies = []
var shark_height = 360
var max_health = 4
var current_health = max_health


func _ready():
	for i in range(100):
		if randf() > 0.7:
			enemies.append(enemy.instance())
		elif randf() > 0.7:
			enemies.append(skull.instance())
		else:
			enemies.append(health.instance())
		enemies[enemies.size() - 1].position.y = shark_height
		enemies[enemies.size() - 1].position.x = (400 + randf()*100) * i
		enemies[enemies.size() - 1].scale = Vector2(2.0, 2.0)
		add_child(enemies[enemies.size() - 1])


func on_hurt():
	if current_health == 3:
		$"UI/User Interface/Health4".visible = false
	if current_health == 2:
		$"UI/User Interface/Health3".visible = false
	if current_health == 1:
		$"UI/User Interface/Health2".visible = false
	if current_health == 0:
		$"UI/User Interface/Health1".visible = false
		
func on_health():
	if current_health == 4:
		$"UI/User Interface/Health4".visible = true
	if current_health == 3:
		$"UI/User Interface/Health3".visible = true
	if current_health == 2:
		$"UI/User Interface/Health2".visible = true
	if current_health == 1:
		$"UI/User Interface/Health1".visible = true
func _on_skull_overlap(body):
	current_health -= 1
	print(current_health)
	on_hurt()

func _on_enemy_overlap(body):
	print("emeny")
	current_health -= 1
	on_hurt()
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_health_overlap(body):
	current_health += 1
	if current_health > max_health:
		current_health = max_health
	on_health()

func _process(delta):
	$AudioStreamPlayer.pitch_scale += delta * 0.01
	var x_camera_player_diff = $Camera2D.position.x - $Player/Player.position.x
	var y_camera_player_diff = $Camera2D.position.y - $Player/Player.position.y
	if x_camera_player_diff >= 50:
		$Camera2D.position.x = $Player/Player.position.x + 50
	if x_camera_player_diff <= -50:
		$Camera2D.position.x = $Player/Player.position.x - 50
	$Camera2D.position.y = $Player/Player.position.y - 50
	score += delta*2
	update_interface()
