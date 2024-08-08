extends State
class_name EnemyAttack

@onready var enemyController = get_node("../../EnemyController")
var enemy: CharacterBody2D
var animPlayer: AnimationPlayer

var playerTargets = []
var player: CharacterBody2D

func _ready():
	enemy = enemyController.getCharacterBody()
	animPlayer = enemyController.getAnimPlayer()
func Enter():
	playerTargets = enemyController.getPlayerTargets()
		
func Update(_delta):
	if enemy.isDead == true:
		Transitioned.emit(self,"enemy_death")
	if enemyController.player_within_range():
		if enemyController.attack_target() and enemyController.player_within_attack_range():
			animPlayer.play("attack01")

	if enemy.position.distance_to(playerTargets[0].get_position()) > 25:
		Transitioned.emit(self,"enemy_follow")

#Interrupt state
func _on_health_component_damage_blocked():
	if enemy.isDead == false:
		Transitioned.emit(self,"enemy_block")
func _on_health_component_damage_hurt(_dmg):
	if enemy.isDead == false:
		Transitioned.emit(self,"enemy_hurt")

