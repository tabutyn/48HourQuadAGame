extends KinematicBody2D

var current_x_velocity = 0.0
var current_y_velocity = 0.0

var jerk = 1.0
var walk_target = 100.0
var run_target = 300.0
var current_target = 100.0

var current_jump_time = 0.0
var gravity = 4000.0
var neutral_friction = 1000.0
var opposing_friction = 2000.0
var jump_up_time = 0.3
var up_down_speed = 500.0

var is_dead = false

func done_rising():
	if current_jump_time >= jump_up_time:
		return true
	else:
		return false

func is_free_falling():
	if current_y_velocity >= up_down_speed:
		return false
	else:
		return true

func _physics_process(delta):
	if is_dead == false:
		var result_vector = move_and_slide(Vector2(current_x_velocity, current_y_velocity), Vector2(0.0, -1.0))
		current_x_velocity = result_vector.x
		current_y_velocity = result_vector.y
		if Input.is_action_just_pressed("jump") and is_on_floor():
			current_jump_time = 0.0
		if Input.is_action_pressed("jump"):
			current_jump_time += delta
			if !done_rising():
				current_y_velocity = -up_down_speed
			elif done_rising() and is_free_falling():
				current_y_velocity += delta * gravity
			else:
				current_y_velocity = up_down_speed
		else:
			current_jump_time = jump_up_time
			if is_free_falling():
				current_y_velocity += delta * gravity
			
		if Input.is_action_pressed("right"):
			var acceleration = 0.0
			if current_x_velocity < 0.0:
				acceleration = 8.0
			else:
				acceleration = 14.0
			current_x_velocity += (current_target - current_x_velocity) * delta * acceleration
			if current_x_velocity < 0.0:
				current_target += (walk_target - current_target) * delta * 20.0 * jerk
			if current_x_velocity > 0.0:
				current_target += (run_target - current_target) * delta * jerk
		elif Input.is_action_pressed("left"):
			var acceleration = 0.0
			if current_x_velocity > 0.0:
				acceleration = 10.0
			else:
				acceleration = 20.0
			current_x_velocity += (-current_target - current_x_velocity) * delta * acceleration
			if current_x_velocity > 0.0:
				current_target += (walk_target - current_target) * delta * 20.0 * jerk
			if current_x_velocity < 0.0:
				current_target += (run_target - current_target) * delta * jerk
		else:
			current_target += (walk_target - current_target) * delta * 1.0
			if current_x_velocity < 0.0:
				current_x_velocity += delta * neutral_friction
				current_x_velocity = min(0.0, current_x_velocity)
			if current_x_velocity > 0.0:
				current_x_velocity -= delta * neutral_friction
				current_x_velocity = max(0.0, current_x_velocity)
<<<<<<< HEAD
	
	if position.x > 500:
=======
	if position.x > 50000:
>>>>>>> ff1d002a9d58572188c894553fe9df1a6c6e15bc
		dead() 
	
func dead():
	is_dead = true 
	get_tree().change_scene("res://Game Over.tscn")
	$Timer.start() 
	
func _on_Timer_timeout() -> void:
	print("Jack")
	
