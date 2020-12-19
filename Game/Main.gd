extends Node2D

var current_x_velocity = 0.0
var current_y_velocity = 0.0

var jerk = 1.0
var walk_target = 100.0
var run_target = 300.0
var current_target = 100.0

var current_jump_time = 0.0
var gravity = 1000.0
var neutral_friction = 1000.0
var opposing_friction = 2000.0
var jump_up_time = 0.4
var up_down_speed = 300.0
var is_on_floor = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.position = $Player.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x_camera_player_diff = $Camera2D.position.x - $Player.position.x
	var y_camera_player_diff = $Camera2D.position.y - $Player.position.y
	if x_camera_player_diff >= 50:
		$Camera2D.position.x = $Player.position.x + 50
	if x_camera_player_diff <= -50:
		$Camera2D.position.x = $Player.position.x - 50

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
	print(current_y_velocity)
	var result_vector = $Player.move_and_slide(Vector2(current_x_velocity, current_y_velocity))
	if Input.is_action_just_pressed("jump") and $Player.is_on_floor():
		print("jump")
		current_jump_time = 0.0
	if Input.is_action_pressed("jump"):
		current_jump_time += delta
	else:
		current_jump_time = jump_up_time
	if !done_rising():
		current_y_velocity = -up_down_speed
	elif done_rising() and is_free_falling():
		current_y_velocity += delta * gravity
	else:
		current_y_velocity = up_down_speed
		
	if Input.is_action_pressed("right"):
		print(current_target)
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
