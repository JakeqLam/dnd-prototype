extends State
class_name EnemyAttack
@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var sprite = get_node("../../Sprite2D")

@export var parent: CharacterBody2D

func Enter():
	print("Attack state")
	animationPlayer.play("attack01")

func Update(_delta):
	if parent.currentHP <= 0:
		Transitioned.emit(self,"death")
