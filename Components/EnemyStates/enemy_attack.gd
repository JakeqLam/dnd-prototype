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
	print("enemy attack state")
	playerTargets = enemyController.getPlayerTargets()
	if enemyController.player_within_range():
		if enemyController.attack_target():
			animPlayer.play("attack01")
		else:
			Transitioned.emit(self,"enemy_idle")
			
	player = get_tree().get_first_node_in_group("player")
	var direction = player.global_position - enemy.global_position
	print(direction.length())
	if direction.length() > 25:
		print("follow him!!")
		Transitioned.emit(self,"enemy_follow")
func Update(_delta):
	if enemy.isDead == true:
		Transitioned.emit(self,"enemy_death")
	#Monitor target health
	if enemyController.target_destroyed():
		Transitioned.emit(self,"enemy_idle")
	
#Interrupt state
func _on_health_component_damage_blocked():
	if enemy.isDead == false:
		Transitioned.emit(self,"enemy_block")
func _on_health_component_damage_hurt(_dmg):
	if enemy.isDead == false:
		Transitioned.emit(self,"enemy_hurt")
