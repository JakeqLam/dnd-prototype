extends State
class_name walk

@onready var playerController = get_node("../../PlayerController")

var animPlayer: AnimationPlayer
var player: CharacterBody2D
var hitbox: Area2D
var MOVE_SPEED: int = 20
var target = Vector2()
func _ready():
	player = playerController.getCharacterBody()
	animPlayer = playerController.getAnimPlayer()
	hitbox = playerController.getWeapon()
	target = player.position
func Enter():
	animPlayer.play("walk")
	MOVE_SPEED = player.moveSpeed
func Update(_delta):
	if player.isDead == true:
		Transitioned.emit(self,"death")
func Physics_Update(_delta):
	if player.follow_cursor == true:
		target = player.get_global_mouse_position()
	
	var direction =  player.global_position - target
	playerController.move_unit_to_positon(target)
	
	#if unit has stopped, go to idle
	if direction.length() < 1:
		Transitioned.emit(self, "idle")
	return null

#Movement interruptions
func _on_health_component_damage_hurt(_dmg):
	Transitioned.emit(self,"hurt")
func _on_health_component_damage_blocked():
	Transitioned.emit(self,"block")
