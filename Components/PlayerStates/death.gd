extends State
class_name death
@onready var playerController = get_node("../../PlayerController")

var player: CharacterBody2D
var animPlayer: AnimationPlayer

func _ready():
	player = playerController.getCharacterBody()
	animPlayer = playerController.getAnimPlayer()
func Enter():
	animPlayer.play("death")
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death":
		playerController.disableAllCol()

