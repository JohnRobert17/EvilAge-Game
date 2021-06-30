extends KinematicBody2D
const SPEED = 250
var health = 200;
var isAlive = true;
var velocity: Vector2 = Vector2()
var isPlayerAttacking = false
onready var joystick = $"/root/Global".joystick
onready var mainscene = $"/root/Global".mainscene
var isDashing = false
var isHurt = false
var maxValue = 0.00001


func _physics_process(delta):
	if (isAlive):
		#set_z_index(get_position().y)
		set_z_index($GroundArea.global_position.y)
		velocity.x = 0
		velocity.y = 0
		if (!isPlayerAttacking and !isHurt):
			if ((Input.is_action_pressed("move_left")) and (Input.is_action_pressed("move_right"))): velocity.x = 0
			elif (Input.is_action_pressed("move_left") or joystick.get_value().x < 0): 
				velocity.x -= SPEED
				if (joystick.get_value().x < 0): velocity.x *= -joystick.get_value().x
			elif (Input.is_action_pressed("move_right") or joystick.get_value().x > 0): 
				velocity.x += SPEED
				if (joystick.get_value().x > 0): velocity.x *= joystick.get_value().x
			if ((Input.is_action_pressed("move_up")) and (Input.is_action_pressed("move_down"))): velocity.y = 0
			elif (Input.is_action_pressed("move_up") or joystick.get_value().y < 0): 
				velocity.y -= SPEED * 0.6
				if (joystick.get_value().y < 0): velocity.y *= -joystick.get_value().y
			elif (Input.is_action_pressed("move_down") or joystick.get_value().y > 0): 
				velocity.y += SPEED * 0.6
				if (joystick.get_value().y > 0): velocity.y *= joystick.get_value().y
			if (maxValue > joystick.get_value().y): maxValue = joystick.get_value().y
			#print(maxValue)
			if (isDashing):
				velocity.x *= 2
				$Sprite.play("dash")
				if (velocity.x > 0): $Sprite.scale.x = 1
				elif (velocity.x < 0): $Sprite.scale.x = -1
			elif (velocity.y != 0 or velocity.x != 0): 
				$Sprite.play("running")
				if (velocity.x > 0): $Sprite.scale.x = 1
				elif (velocity.x < 0): $Sprite.scale.x = -1
			else : $Sprite.play("idle")
		#elif(isPlayerAttacking): 
			#velocity.x += (SPEED/4) * $Sprite.scale.x
		if (Input.is_action_just_pressed("attack")): 
			attack_melee()
		elif (Input.is_action_just_pressed("dash")): 
			move_dash()
		move_and_slide(velocity, Vector2.UP)
#const 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"/root/Global".register_player(self)

func attack_melee():
	if (!isPlayerAttacking):
		$Sprite.play("slashing")
		$Sprite/SlashHit/CollisionShape2D.disabled = false
		isPlayerAttacking = true

func move_dash():
	if ((velocity.x > 20) or (velocity.x < -20) and !isDashing and !isPlayerAttacking):
		isDashing = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SlashHit_area_entered(area):
	if (area.is_in_group("hitbox")):
		pass


func _on_Sprite_animation_finished():
	if (isAlive): Neutralize()

func Neutralize():
	isHurt = false
	isDashing = false
	isPlayerAttacking = false
	$Sprite/SlashHit/CollisionShape2D.disabled = true
	$Sprite.play("idle")

func _on_PlayerHitbox_area_entered(area):
	if (isAlive):
		if (area.is_in_group("EnemyDamage")):
			if (area.is_in_group("MeleeC")): health -= 10
			hurt()

func hurt():
	print(health)
	isHurt = true
	if (health <= 0): 
		isAlive = false
		$Sprite.play("die")
	else: $Sprite.play("hurt")
