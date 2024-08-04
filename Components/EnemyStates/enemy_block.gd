extends State
class_name EnemyBlock


@onready var enemyController = get_node("../../EnemyController")
var animPlayer = AnimationPlayer
var enemy: CharacterBody2D

func _ready():
	animPlayer = enemyController.getAnimPlayer()
	enemy = enemyController.getCharacterBody()
func Enter():
	animPlayer.play("block")

func Update(_delta):
	if enemy.isDead == true:
		Transitioned.emit(self,"enemy_death")

func _on_animation_player_animation_finished(_anim_name):
	if enemy.isDead == false:
		Transitioned.emit(self, "enemy_idle")
