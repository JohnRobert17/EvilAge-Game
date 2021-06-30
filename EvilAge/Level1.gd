extends Node2D
var Menu = load("res://Menu.tscn")
var Level1 = load("res://Level1.tscn")

func _process(delta):
	if ($Player.position.x - $BackBorder.position.x > 550): $BackBorder.position.x = $Player.position.x - 500
func _ready():
	pass # Replace with function body.


func _on_TouchScreenButton_pressed():
	print("Game restarted")
	$"/root/Global".mainscene.NextScene(Level1)



func _on_Back_pressed():
	print("Back to main menu")
	$"/root/Global".mainscene.NextScene(Menu)
