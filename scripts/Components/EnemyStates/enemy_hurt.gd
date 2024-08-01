extends State
class_name EnemyHurt

@onready var animationPlayer = get_node("../../AnimationPlayer")

@export var VFX: VFXSpawner
@export var enemy: CharacterBody2D

func Enter():
	animationPlayer.play("hurt")
	VFX.spawn_effect(VFX.EFFECT_HIT, enemy.global_position)

func Update(_delta):
	if enemy.isDead == true:
		Transitioned.emit(self,"enemy_death")
	
func _on_animation_player_animation_finished(_anim_name):
	if enemy.isDead == false:
		Transitioned.emit(self, "enemy_idle")
