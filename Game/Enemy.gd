extends Node2D
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var idle_counter = 0
var idle_counter_max = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$idle/idleplayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_idleplayer_animation_finished(anim_name):
	idle_counter += 1
	if idle_counter > idle_counter_max:
		idle_counter = 0
		$jump/jumpplayer.play("jump")
		$jump/jumpplayer.seek(0.0)
		$jump.visible = true
		$jump/Area2D/CollisionShape2D.disabled = false
		$idle.visible = false
	else:
		$idle/idleplayer.play("idle")
		$idle.visible = true
		$jump.visible = false
		$jump/Area2D/CollisionShape2D.disabled = true

func _on_jumpplayer_animation_finished(anim_name):
	$idle/idleplayer.play("idle")
	$idle.visible = true
	$jump.visible = false
	$jump/Area2D/CollisionShape2D.disabled = false
