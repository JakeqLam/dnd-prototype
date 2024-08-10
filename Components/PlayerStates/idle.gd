extends State
class_name idle

@onready var playerController = get_node("../../PlayerController")

var animPlayer: AnimationPlayer
var player: CharacterBody2D
var enemyTargets = []

func _ready():
	player = playerController.getCharacterBody()
	animPlayer = playerController.getAnimPlayer()
func Enter():
	enemyTargets = playerController.getEnemyTargets() #if enemyTargets array is 0, idle.
	animPlayer.play("idle")
	
func _input(event: InputEvent):
	if player.isSelected == true:
		if event.is_action_pressed("right_click"):
				player.toggle_cursor_state(true)
				if player.isDead == false:
					Transitioned.emit(self,"walk")
		if event.is_action_released("right_click"):
				player.toggle_cursor_state(false)
	return null
func Physics_Update(_delta):
	
	if playerController.enemy_within_range():
		if playerController.enemy_within_attack_range():
			Transitioned.emit(self,"attack")
			
	if player.isDead == true:
		Transitioned.emit(self,"death")


#Interrupt states
func _on_health_component_damage_hurt(_dmg):
	if player.isDead == false:
		Transitioned.emit(self,"hurt")
func _on_health_component_damage_blocked():
	if player.isDead == false:
		Transitioned.emit(self,"block")
