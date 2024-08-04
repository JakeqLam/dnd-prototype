extends State
class_name EnemyHurt

@onready var enemyController = get_node("../../EnemyController")
var animPlayer = AnimationPlayer
var enemy: CharacterBody2D
var VFX: VFXSpawner

func _ready():
	animPlayer = enemyController.getAnimPlayer()
	enemy = enemyController.getCharacterBody()
	VFX = enemyController.getVFXSpawner()
func Enter():
	animPlayer.play("hurt")
	VFX.spawn_effect(VFX.EFFECT_HIT, enemy.global_position)

func Update(_delta):
	if enemy.isDead == true:
		Transitioned.emit(self,"enemy_death")
	
func _on_animation_player_animation_finished(_anim_name):
	if enemy.isDead == false:
		Transitioned.emit(self, "enemy_idle")
		
func _on_health_component_damage_hurt(dmg):
	VFX.spawn_dmgIndicator(dmg)
