extends State
class_name EnemyAttack
@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var atkTimer = get_node("../../AttackSpeedTimer")
@onready var wpnDamage = get_node("../../HitboxComponent")
@export var enemy: CharacterBody2D

var atkSpd: float = 2.5
var atkCooldown:bool = false
var playerTargets = []
func Enter():
	playerTargets = get_tree().get_nodes_in_group("PlayerTargets")
	atkSpd = enemy.wpnSpd
	atkTimer.wait_time = atkSpd #Set the attack speed of a weapon
	wpnDamage.generateDMG(enemy.wpnDmgMin, enemy.wpnDmgMax) #Generate damage between a range
	if playerTargets.size() != 0:
		if enemy.isDead == false:
			if atkCooldown == false:
				animationPlayer.play("attack01")
				atkCooldown = true
				atkTimer.start()
			elif atkCooldown == true:
				Transitioned.emit(self,"enemy_idle")

func Update(_delta):
	if enemy.isDead == true:
		Transitioned.emit(self,"enemy_death")
	if playerTargets.size() > 0:
		if playerTargets[0].isDead == true:
			playerTargets[0].remove_from_group("PlayerTargets") #remove the enemy target if dead
			playerTargets.remove_at(0)
			atkTimer.stop()
			Transitioned.emit(self,"enemy_idle")

func _on_attack_speed_timer_timeout():
	if enemy.isDead == false:
		animationPlayer.play("attack01")
func _on_health_component_damage_hurt(_dmg):
	if enemy.isDead == false:
		Transitioned.emit(self,"enemy_hurt")
func _on_health_component_damage_blocked():
	if enemy.isDead == false:
		Transitioned.emit(self,"enemy_block")
