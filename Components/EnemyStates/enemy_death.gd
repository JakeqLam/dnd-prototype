extends State
class_name EnemyDeath

@onready var enemyController = get_node("../../EnemyController")
var animPlayer = AnimationPlayer
var enemy: CharacterBody2D

func _ready():
	animPlayer = enemyController.getAnimPlayer()
	enemy = enemyController.getCharacterBody()
func Enter():
	animPlayer.play("death")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death":
		enemyController.disableAllCol()
