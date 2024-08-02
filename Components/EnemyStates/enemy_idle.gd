extends State
class_name EnemyIdle
@onready var animationPlayer = get_node("../../AnimationPlayer")

@export var enemy: CharacterBody2D
@onready var target = enemy.position
var playerTargets = []
func Enter():
	playerTargets = get_tree().get_nodes_in_group("PlayerTargets")
	animationPlayer.play("idle")
	enemy.velocity.x = 0

func Update(_delta):
	if playerTargets.size() > 0:
		if enemy.isDead == false and enemy.position.distance_to(playerTargets[0].get_position()) < enemy.wpnRange:
			Transitioned.emit(self,"enemy_attack")
	if enemy.isDead == true:
		Transitioned.emit(self,"death")
func _on_health_component_damage_hurt(_dmg):
	if enemy.isDead == false:
		Transitioned.emit(self,"enemy_hurt")
func _on_health_component_damage_blocked():
	if enemy.isDead == false:
		Transitioned.emit(self,"enemy_block")
func _on_enemy_detector_body_entered(body):
	if body.is_in_group("player"):
		Transitioned.emit(self,"enemy_follow")
		if body.isDead == false:
			body.add_to_group("PlayerTargets")
			playerTargets = get_tree().get_nodes_in_group("PlayerTargets")
