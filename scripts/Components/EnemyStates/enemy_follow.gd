extends State
class_name EnemyFollow

@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var sprite = get_node("../../Sprite2D")
@onready var hitbox = get_node("../../HitboxComponent")

@export var enemy: CharacterBody2D
@export var move_speed:int = 20

var player : CharacterBody2D


func Enter():
	print("Enemy walking state")
	animationPlayer.play("walk")
	player = get_tree().get_first_node_in_group("player")

func Update(_delta):
	if enemy.isDead == false:
		Transitioned.emit(self,"enemy_death")

func Physics_Update(_delta):
	
	var direction = player.global_position - enemy.global_position
	if direction.length() > 25:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()
		Transitioned.emit(self, "enemy_idle")

	if direction.length() > 20:
		Transitioned.emit(self, "enemy_idle")
	
	if enemy.position.distance_to(player.get_position()) > 1:
		if enemy.position.x > player.position.x:
			sprite.flip_h = true
			#Flip the collision shape of hitbox to match sprite
			hitbox.scale.x = -1
			hitbox.scale.y = -1
			#hitbox.rotation = 45
			hitbox.position.x = -10
			hitbox.position.y = 1
		elif enemy.position.x <= player.position.x:
			sprite.flip_h = false
			#Flip the collision shape of hitbox to match sprite
			hitbox.scale.x = 1
			hitbox.scale.y = 1
			#hitbox.rotation = 135
			hitbox.position.x = 10
			hitbox.position.y = -1
		enemy.move_and_slide()
	
	if direction.length() < 1:
		Transitioned.emit(self, "enemy_idle")
	return null

func _on_health_component_damage_hurt(_dmg):
	Transitioned.emit(self,"enemy_hurt")
func _on_health_component_damage_blocked():
	Transitioned.emit(self,"enemy_block")
