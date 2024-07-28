extends State
class_name hurt
@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var sprite = get_node("../../Sprite2D")

@export var parent: CharacterBody2D

func Enter():
	print("hurt state")
	animationPlayer.play("hurt")

func Update(_delta):
	if parent.currentHP <= 0:
		Transitioned.emit(self,"death")
		
func _on_animation_player_animation_finished():
		Transitioned.emit(self, "idle")
