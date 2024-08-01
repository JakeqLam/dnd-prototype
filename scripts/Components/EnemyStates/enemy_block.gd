extends State
class_name EnemyBlock
@onready var animationPlayer = get_node("../../AnimationPlayer")

@export var enemy: CharacterBody2D

func Enter():
	animationPlayer.play("block")

func Update(_delta):
	if enemy.isDead == true:
		Transitioned.emit(self,"enemy_death")

func _on_animation_player_animation_finished(_anim_name):
	if enemy.isDead == false:
		Transitioned.emit(self, "enemy_idle")
