extends State
class_name hurt

@onready var playerController = get_node("../../PlayerController")

var VFX: VFXSpawner
var player: CharacterBody2D
var animPlayer: AnimationPlayer

func _ready():
	player = playerController.getCharacterBody()
	animPlayer = playerController.getAnimPlayer()
	VFX = playerController.getVFXSpawner()

func Enter():
	animPlayer.play("hurt")
	VFX.spawn_effect(VFX.EFFECT_HIT, player.global_position)

func Update(_delta):
	if player.isDead == true:
		Transitioned.emit(self,"death")
func _on_animation_player_animation_finished(_anim_name):
	if player.isDead == false:
		Transitioned.emit(self, "idle")
func _on_health_component_damage_hurt(dmg):
	VFX.spawn_dmgIndicator(dmg)
