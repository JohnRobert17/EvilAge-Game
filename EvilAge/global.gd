extends Node
var joystick
var player
var mainscene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func register_player(in_player):
	player = in_player
	
func register_joystick(in_joystick):
	joystick = in_joystick


func register_mainscene(in_mainscene):
	mainscene = in_mainscene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
