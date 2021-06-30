extends CanvasLayer

signal transitioned


func transition():
	fade_out()

func fade_in():
	$AnimationPlayer.play("fadein")
	
	
func fade_out():
	$AnimationPlayer.play("fadeout")


func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "fadeout"):
		print("Emit signal transitioned")
		emit_signal("transitioned")
		fade_in()
	if (anim_name == "fadein"):
		print("finished")
