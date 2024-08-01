extends State
class_name hurt
@onready var animationPlayer = get_node("../../AnimationPlayer")

@export var parent: CharacterBody2D
@export var VFX: VFXSpawner

func Enter():
	animationPlayer.play("hurt")
	VFX.spawn_effect(VFX.EFFECT_HIT, parent.global_position)

func Update(_delta):
	if parent.isDead == true:
		Transitioned.emit(self,"death")
		
func _on_animation_player_animation_finished(_anim_name):
	if parent.isDead == false:
		Transitioned.emit(self, "idle")
		
func _on_health_component_damage_hurt(dmg):
	VFX.spawn_dmgIndicator(dmg)
