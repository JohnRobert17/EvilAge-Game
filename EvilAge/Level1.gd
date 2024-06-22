extends Node2D
var Menu = load("res://Menu.tscn")
var Level1 = load("res://Level1.tscn")

func _process(delta):
	if (($Player.position.x - $BackBorder.position.x > 800) and ($BackBorder.position.x < 5500)):
		 $BackBorder.position.x = $Player.position.x - 750
	$Player/Camera2D.limit_left = $BackBorder.position.x + 100 + ($BackBorder.position.x/10)
func _ready():
	$Player/Camera2D.limit_right = 7800


func _on_TouchScreenButton_pressed():
	print("Game restarted")
	$"/root/Global".mainscene.NextScene(Level1)



func _on_Back_pressed():
	print("Back to main menu")
	$"/root/Global".mainscene.NextScene(Menu)
