extends State
class_name EnemyBlock
@onready var animationPlayer = get_node("../../AnimationPlayer")

@export var parent: CharacterBody2D

func Enter():
	print("Enemy Block State")
	animationPlayer.play("block")

func Update(_delta):
	if parent.currentHP <= 0:
		Transitioned.emit(self,"enemy_death")

func _on_animation_player_animation_finished(_anim_name):
	Transitioned.emit(self, "enemy_idle")
