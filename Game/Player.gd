extends "res://Main.gd"


func dead():
	is_dead = true 
	current_x_velocity = 0
	$AnimatedSprite.play("DeathAnimation")
	$CollisionShape2d.disabled = true
	$Timer.start()
func _on_Timer_timeout() -> void:
	get_tree().change_scene("res://Game Over.tscn")
	if $Player.position.x == 500:
		dead() 
