extends State
class_name block
@onready var animationPlayer = get_node("../../AnimationPlayer")

@export var parent: CharacterBody2D

func Enter():
	print("block state")
	animationPlayer.play("block")

func Update(_delta):
	if parent.currentHP <= 0:
		Transitioned.emit(self,"death")


func _on_animation_player_animation_finished(_anim_name):
	Transitioned.emit(self, "idle")
