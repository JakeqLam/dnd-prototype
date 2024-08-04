extends State
class_name block
@onready var playerController = get_node("../../PlayerController")

var player: CharacterBody2D
var animPlayer: AnimationPlayer

func _ready():
	player = playerController.getCharacterBody()
	animPlayer = playerController.getAnimPlayer()
func Enter():
	animPlayer.play("block")
func Update(_delta):
	if player.isDead == true:
		Transitioned.emit(self,"death")
func _on_animation_player_animation_finished(_anim_name):
	if player.isDead == false:
		Transitioned.emit(self, "idle")
