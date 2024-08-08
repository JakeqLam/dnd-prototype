extends Node
#This is an intermediate controller for the Player Characters.
#This is a middle communication point between the states and the logic
#Wire all components to this class
class_name PlayerController

@onready var colShape = get_node("../CollisionShape2D")
@onready var enemDetCol = get_node("../EnemyDetector/CollisionShape2D")
@onready var hurtboxCol = get_node("../HurtboxComponent/CollisionShape2D")
@onready var hitboxCol = get_node("../HitboxComponent/CollisionShape2D")
@onready var sprite = get_node("../Sprite2D")

#Wired up components
@export var player: CharacterBody2D
@export var animPlayer = AnimationPlayer
@export var weapon = Area2D
@export var hurtbox = Area2D
@export var VFX: VFXSpawner
@export var atkTimer: Timer

var enemyTargets = []
var atkCooldown = false
var atkSpd: float = 3.0

#Setting UI functions

#Moving functions
func move_unit_to_positon(target):
	player.velocity = player.position.direction_to(target) * player.moveSpeed
	if player.position.distance_to(target) > 1:
		#flip sprite left
		if player.position.x > target.x:
			sprite.flip_h = true
			#Flip the collision shape of hitbox to match sprite
			weapon.scale.x = -1
			weapon.scale.y = -1
			#hitbox.rotation = 45
			weapon.position.x = -16
			weapon.position.y = 1
		#Flip sprite right
		elif player.position.x <= target.x:
			sprite.flip_h = false
			#Flip the collision shape of hitbox to match sprite
			weapon.scale.x = 1
			weapon.scale.y = 1
			#hitbox.rotation = 135
			weapon.position.x = 16
			weapon.position.y = -1
		player.move_and_slide()
#Unit Combat Systems
func attack_target():
	atkSpd = player.wpnSpd 
	atkTimer.wait_time = atkSpd #Set the attack speed of a weapon
	#Attack logic
	if atkCooldown == false:
		weapon.generateDMG(player.wpnDmgMin, player.wpnDmgMax) #Generate damage between a range
		atkTimer.start()
		atkCooldown = true
		return true
	else:
		return false
func _on_attack_speed_timer_timeout():
	if player.isDead == false:
		if enemy_within_range():
			atkCooldown = false

#Unit targeting Systems
func getEnemyTargets():
	enemyTargets = get_tree().get_nodes_in_group("EnemyTargets")
	return enemyTargets
func enemy_within_range():
	if enemyTargets.size() > 0:
		return true
	return false
func enemy_within_attack_range():
	if player.isDead == false and player.position.distance_to(enemyTargets[0].get_position()) <= player.wpnRange:
		return true
	else:
		return false
#if enemy unit enters range
func _on_enemy_detector_body_entered(body):
	if body.is_in_group("enemy"):
		body.add_to_group("EnemyTargets")

func target_destroyed():
	if enemy_within_range() == true:
		if enemyTargets[0].isDead == true:
			enemyTargets[0].remove_from_group("EnemyTargets") #remove the enemy target if dead
			enemyTargets.remove_at(0)
			atkTimer.stop()
			return true
		else: 
			return false

#References for all node references to the character
func getCharacterBody():
	return player
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



