extends State
class_name block
@onready var animationPlayer = get_node("../../AnimationPlayer")

@export var parent: CharacterBody2D

func Enter():
	animationPlayer.play("block")

func Update(_delta):
	if parent.isDead == true:
		Transitioned.emit(self,"death")

func _on_animation_player_animation_finished(_anim_name):
	if parent.isDead == false:
		Transitioned.emit(self, "idle")
