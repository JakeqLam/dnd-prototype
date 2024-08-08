extends State
class_name attack

@onready var playerController = get_node("../../PlayerController")
var player: CharacterBody2D
var animPlayer: AnimationPlayer
var isAttacking = false
var enemyTargets = []

func _ready():
	player = playerController.getCharacterBody()
	animPlayer = playerController.getAnimPlayer()
func Enter():
	enemyTargets = playerController.getEnemyTargets()
func _input(event: InputEvent):
	if event.is_action_pressed("right_click"):
			player.toggle_cursor_state(true)
			if isAttacking == false:
				Transitioned.emit(self,"walk")
	if event.is_action_released("right_click") and isAttacking == false:
			player.toggle_cursor_state(false)
	return null
func Update(_delta):
	if player.isDead == true:
		Transitioned.emit(self,"death")
	if playerController.enemy_within_range():
			if playerController.attack_target() and playerController.enemy_within_attack_range():
				animPlayer.play("attack01")
				isAttacking = true
	#Monitor target health
	if playerController.target_destroyed():
		Transitioned.emit(self,"idle")
		
#Interrupt state
func _on_health_component_damage_blocked():
	if player.isDead == false:
		Transitioned.emit(self,"block")
func _on_health_component_damage_hurt(_dmg):
	if player.isDead == false:
		Transitioned.emit(self,"hurt")
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack01":
		isAttacking = false
