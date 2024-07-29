extends State
class_name hurt
@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var sprite = get_node("../../Sprite2D")

@export var parent: CharacterBody2D
@export var VFX: VFXSpawner

func Enter():
	print("hurt state")
	animationPlayer.play("hurt")
	VFX.spawn_effect(VFX.EFFECT_HIT, parent.global_position)

func Update(_delta):
	if parent.currentHP <= 0:
		Transitioned.emit(self,"death")
		
func _on_animation_player_animation_finished(_anim_name):
		Transitioned.emit(self, "idle")