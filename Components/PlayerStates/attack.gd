extends State
class_name attack

@onready var playerController = get_node("../../PlayerController")
var player: CharacterBody2D
var animPlayer: AnimationPlayer

var enemyTargets = []

func _ready():
	player = playerController.getCharacterBody()
	animPlayer = playerController.getAnimPlayer()
func Enter():
	if playerController.attack_target() == true:
		animPlayer.play("attack01")
	else:
		Transitioned.emit(self,"idle")

func _input(event: InputEvent):
	if event.is_action_pressed("right_click"):
			player.toggle_cursor_state(true)
			Transitioned.emit(self,"walk")
	if event.is_action_released("right_click"):
			player.toggle_cursor_state(false)
	return null
func Update(_delta):
	if player.isDead == true:
		Transitioned.emit(self,"death")
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
