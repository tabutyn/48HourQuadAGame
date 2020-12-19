extends "res://Main.gd"


func dead():
	is_dead = true 
	current_x_velocity = 0
	$AnimatedSprite.play("animationname")
	$CollisionShape2d.disabled = true
	$Timer.start()
func _on_Timer_timeout() -> void:
	pass # Replace with function body.
