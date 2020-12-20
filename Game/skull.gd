extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_no_fire_player_animation_finished(anim_name):
	$fire/fire_player.play("fire")
	$no_fire.visible=false
	$fire.visible=true


func _on_fire_player_animation_finished(anim_name):
	$fire/fire_player.play("fire")
