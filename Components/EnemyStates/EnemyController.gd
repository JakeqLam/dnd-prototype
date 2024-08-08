extends Node
#This is an intermediate controller for the enemy Characters.
#This is a middle communication point between the states and the logic
#Wire all components to this class
class_name EnemyController

@onready var colShape = get_node("../CollisionShape2D")
@onready var enemDetCol = get_node("../EnemyDetector/CollisionShape2D")
@onready var hurtboxCol = get_node("../HurtboxComponent/CollisionShape2D")
@onready var hitboxCol = get_node("../HitboxComponent/CollisionShape2D")
@onready var sprite = get_node("../Sprite2D")

#Wired up components
@export var enemy: CharacterBody2D
@export var animPlayer = AnimationPlayer
@export var weapon = Area2D
@export var hurtbox = Area2D
@export var VFX: VFXSpawner
@export var atkTimer: Timer

var playerTargets = []
var atkCooldown = false
var atkSpd: float = 3.0

#Setting UI functions

#Moving functions
func move_unit_to_positon(target):
	enemy.velocity = enemy.position.direction_to(target) * enemy.moveSpeed
	if enemy.position.distance_to(target) > 1:
		#flip sprite left
		if enemy.position.x > target.x:
			sprite.flip_h = true
			#Flip the collision shape of hitbox to match sprite
			weapon.scale.x = -1
			weapon.scale.y = -1
			#hitbox.rotation = 45
			weapon.position.x = -8
			weapon.position.y = 1
		#Flip sprite right
		elif enemy.position.x <= target.x:
			sprite.flip_h = false
			#Flip the collision shape of hitbox to match sprite
			weapon.scale.x = 1
			weapon.scale.y = 1
			#hitbox.rotation = 135
			weapon.position.x = 8
			weapon.position.y = -1
		enemy.move_and_slide()
#Unit Combat Systems
func attack_target():
	atkSpd = enemy.wpnSpd 
	atkTimer.wait_time = atkSpd #Set the attack speed of a weapon
	#Attack logic
	if atkCooldown == false:
		weapon.generateDMG(enemy.wpnDmgMin, enemy.wpnDmgMax) #Generate damage between a range
		atkTimer.start()
		atkCooldown = true
		return true
	else:
		return false
func _on_attack_speed_timer_timeout():
	if enemy.isDead == false:
		if player_within_range():
			atkCooldown = false

#Unit targeting Systems
func getPlayerTargets():
	playerTargets = get_tree().get_nodes_in_group("PlayerTargets")
	return playerTargets
func player_within_range():
	if playerTargets.size() > 0:
		return true
	return false
func player_within_attack_range():
	if enemy.isDead == false and enemy.position.distance_to(playerTargets[0].get_position()) <= enemy.wpnRange:
		return true
	return false

func target_destroyed():
	if player_within_range():
		if playerTargets[0].isDead == true:
			playerTargets[0].remove_from_group("PlayerTargets") #remove the enemy target if dead
			playerTargets.remove_at(0)
			atkTimer.stop()
			return true
		else: 
			return false

#References for all node references to the character
func getCharacterBody():
	return enemy
func getAnimPlayer():
	return animPlayer
func getWeapon():
	return weapon
func getHurtbox():
	return hurtbox
func getVFXSpawner():
	return VFX

#Utility functions
func disableAllCol():
	hurtboxCol.disabled = true
	colShape.disabled = true
	enemDetCol.disabled = true
	hitboxCol.disabled = true
