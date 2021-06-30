extends Node2D
var NewScene = preload("res://Level1.tscn")

func _ready():
	$"/root/Global".register_mainscene(self)

func NextScene(Scene):
	NewScene = Scene
	$TransitionScreen.transition()


func _on_TransitionScreen_transitioned():
	$CurrentScene.get_child(0).queue_free()
	$CurrentScene.add_child(NewScene.instance())
	
