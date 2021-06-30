extends Node2D
const LEVEL1 = preload("res://Level1.tscn")
const About = preload("res://About.tscn")

func _on_Play_pressed():
	print("Pressed play button")
	$"/root/Global".mainscene.NextScene(LEVEL1)
	#get_tree().$TransitionScreen.emit_signal("transitioned")
	
	pass # Replace with function body.



func _on_About_pressed():
	$"/root/Global".mainscene.NextScene(About)
