extends State
class_name EnemyAttack
@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var atkTimer = get_node("../../AttackSpeedTimer")
@export var atkSpd: float = 3.0
@export var enemy: CharacterBody2D

var atkCooldown:bool = false
var playerTargets = []
func Enter():
	playerTargets = get_tree().get_nodes_in_group("PlayerTargets")
	atkTimer.wait_time = atkSpd
	
	if playerTargets.size() != 0:
		if enemy.isDead == false:
			if atkCooldown == false:
				animationPlayer.play("attack01")
				atkCooldown = true
				atkTimer.start()
			elif atkCooldown == true:
				Transitioned.emit(self,"idle")

func _input(event: InputEvent):
	if event.is_action_pressed("right_click"):
			enemy.toggle_cursor_state(true)
			Transitioned.emit(self,"walk")
	if event.is_action_released("right_click"):
			enemy.toggle_cursor_state(false)
	return null

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
func _on_health_component_damage_hurt():
	if enemy.isDead == false:
		Transitioned.emit(self,"enemy_hurt")
func _on_health_component_damage_blocked():
	if enemy.isDead == false:
		Transitioned.emit(self,"enemy_block")
