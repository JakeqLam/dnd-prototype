extends State
class_name attack
@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var atkTimer = get_node("../../AttackSpeedTimer")
@onready var wpnDamage = get_node("../../HitboxComponent")
@export var atkSpd: float = 3.0
@export var parent: CharacterBody2D

var atkCooldown:bool = false

var enemyTargets = []

func Enter():
	enemyTargets = get_tree().get_nodes_in_group("EnemyTargets")
	atkSpd = parent.wpnSpd 
	atkTimer.wait_time = atkSpd #Set the attack speed of a weapon
	wpnDamage.generateDMG(parent.wpnDmgMin, parent.wpnDmgMax) #Generate damage between a range
	if enemyTargets.size() != 0:
		#Attack logic
		if atkCooldown == false:
			animationPlayer.play("attack01")
			atkTimer.start()
			atkCooldown = true
		elif atkCooldown == true:
			Transitioned.emit(self,"idle")

func _input(event: InputEvent):
	if event.is_action_pressed("right_click"):
			parent.toggle_cursor_state(true)
			Transitioned.emit(self,"walk")
	if event.is_action_released("right_click"):
			parent.toggle_cursor_state(false)
	return null

func Update(_delta):
	if parent.isDead == true:
		Transitioned.emit(self,"death")
	if enemyTargets.size() != 0:
		if enemyTargets[0].isDead == true:
			enemyTargets[0].remove_from_group("EnemyTargets") #remove the enemy target if dead
			enemyTargets.remove_at(0)
			atkTimer.stop()
			Transitioned.emit(self,"idle")

func _on_attack_speed_timeout():
	if parent.isDead == false:
		if enemyTargets.size() > 0:
			animationPlayer.play("attack01")
func _on_health_component_damage_blocked():
	if parent.isDead == false:
		Transitioned.emit(self,"block")
func _on_health_component_damage_hurt(_dmg):
	if parent.isDead == false:
		Transitioned.emit(self,"hurt")
