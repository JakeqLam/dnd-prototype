extends State
class_name EnemyFollow
@onready var enemyController = get_node("../../EnemyController")

var animPlayer: AnimationPlayer
var player :CharacterBody2D
var enemy : CharacterBody2D

var MOVE_SPEED: int = 20
var target = Vector2()
func _ready():
	enemy = enemyController.getCharacterBody()
	animPlayer = enemyController.getAnimPlayer()
	target = enemy.position
	MOVE_SPEED = enemy.moveSpeed
	
func Enter():
	print("Enemy walking state")
	player = get_tree().get_first_node_in_group("player")
	animPlayer.play("walk")


func Physics_Update(_delta):
	target = player.get_position()
	var direction = player.global_position - enemy.global_position

	if direction.length() > 25:
		enemy.velocity = direction.normalized() * MOVE_SPEED
	else:
		Transitioned.emit(self, "enemy_idle")
	if direction.length() > 60:
		Transitioned.emit(self, "enemy_idle")
	
	enemyController.move_unit_to_positon(target)
	
	#if unit has stopped, go to idle
	if direction.length() < 1:
		Transitioned.emit(self, "enemy_idle")
	return null

func _on_health_component_damage_hurt(_dmg):
	Transitioned.emit(self,"enemy_hurt")
func _on_health_component_damage_blocked():
	Transitioned.emit(self,"enemy_block")
