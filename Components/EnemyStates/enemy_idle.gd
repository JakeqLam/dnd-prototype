extends State
class_name EnemyIdle

@onready var enemyController = get_node("../../EnemyController")

var enemy: CharacterBody2D
var animPlayer: AnimationPlayer
var playerTargets = []

func _ready():
	enemy = enemyController.getCharacterBody()
	animPlayer = enemyController.getAnimPlayer()
	
func Enter():
	playerTargets = enemyController.getPlayerTargets()
	animPlayer.play("idle")

func Update(_delta):

	if enemyController.player_within_range():
		if enemyController.player_within_attack_range():
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
			playerTargets = enemyController.getPlayerTargets()
