extends Area2D

var dead = false
var hurt = false
var health = 100
var player_position
var velocity: Vector2 = Vector2()
var attacking = false
var death_count: float = 200
var player_in_range = false
var counter = 0
var uniqueAttribute = rand_range(0.5, 1.5)
var SPEED = 1 * uniqueAttribute

func _physics_process(delta):
	if (!$"/root/Global".player.isAlive):
		$Sprite.play("idle")
	elif (dead == true): 
		$Sprite/slash_damage/CollisionShape2D.disabled = true;
		$Sprite.play("dying")
		if (death_count > 0):
			modulate.a = death_count/200
			death_count -= 1
		else:
			get_parent().remove_child(self)
	elif (hurt == false):
		if ((attacking == false) and (player_in_range == false)):
			player_position = $"/root/Global".player.get_position()
			#set_z_index(get_position().y)
			set_z_index($GroundArea.global_position.y)
			if ((get_position().x + player_position.x > 500) and (get_position().x - player_position.x < 500)):
				$Sprite.play("running")
				velocity.x = 0
				velocity.y = 0
				if (get_position().y > player_position.y): velocity.y = - SPEED
				if (get_position().y < player_position.y): velocity.y = + SPEED
				if (get_position().x > player_position.x + 20): velocity.x = - SPEED
				if (get_position().x < player_position.x - 20): velocity.x = + SPEED
				position.x += velocity.x
				position.y += velocity.y
				if (velocity.x > -0.01): $Sprite.scale.x = 1
				elif (velocity.x < 0.01): $Sprite.scale.x = -1
			else: $Sprite.play("idle")
		elif ((player_in_range == true) and (attacking == false)) : attack()
		elif (attacking):
			if (counter >= 25): 
				$Sprite/slash_damage/CollisionShape2D.disabled = false
				counter = 0
			else: counter += 1
	elif (hurt):
		if (get_position().x > player_position.x + 20): velocity.x = + SPEED
		if (get_position().x < player_position.x - 20): velocity.x = - SPEED
		position.x += velocity.x
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_EnemyClassC_area_entered(area):
	if (dead == false):
		if (area.is_in_group("Slash")):
			$Sprite.play("hurt")
			health -= 50
			hurt = true
			print(health)
		if (health <= 0):
			$Sprite.play("dying")
			dead = true
			print("Enemy killed")


func _on_Sprite_animation_finished():
	if ($Sprite.animation == "hurt"): 
		hurt = false
		attacking = false
	elif ($Sprite.animation == "slashing"): 
		attacking = false
		$Sprite/slash_damage/CollisionShape2D.disabled = true;
		


func _on_slash_area_area_entered(area):
	if (area.is_in_group("hitbox")):
		player_in_range = true
		

func _on_slash_damage_area_entered(area):
	pass

func attack():
	if ((dead == false) and (hurt == false)):
		attacking = true
		$Sprite.play("slashing") 


func _on_slash_area_area_exited(area):
	if (area.is_in_group("hitbox")):
		player_in_range = false
