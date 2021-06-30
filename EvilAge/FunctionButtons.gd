extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Melee_pressed():
	$"/root/Global".player.attack_melee()


func _on_Dash_pressed():
	if ($"/root/Global".player.isPlayerAttacking == false):
		$"/root/Global".player.move_dash()
