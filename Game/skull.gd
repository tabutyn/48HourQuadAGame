extends Node2D

var up_stroke = true

signal overlap(body)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_no_fire_player_animation_finished(anim_name):
	if up_stroke:
		$no_fire.visible=false
		$fire.visible=true
		$fire/fire_player.play("fire")
		$fire/fire_player.seek(0.0)
		$fire/Area2D/CollisionShape2D.disabled = false
	else:
		$no_fire/no_fire_player.play("lift_off")
		$fire/fire_player.seek(0.0)
		up_stroke = true

func _on_fire_player_animation_finished(anim_name):
	$fire.visible = false
	$no_fire.visible = true
	$no_fire/no_fire_player.play("drop_down")
	$fire/fire_player.seek(0.0)
	up_stroke = false
	$fire/Area2D/CollisionShape2D.disabled = true


func _on_Area2D_body_entered(body):
	var main = get_parent()
	main._on_skull_overlap(body)
	emit_signal("overlap", body)

