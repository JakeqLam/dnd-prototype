extends State
class_name EnemyIdle
@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var sprite = get_node("../../Sprite2D")

@export var parent: CharacterBody2D
@onready var target = parent.position
var playerTargets = []
func Enter():
	print("Enemy Idle state")
	animationPlayer.play("idle")
	parent.velocity.x = 0

func Update(_delta):
	if playerTargets.size() > 0:
		if parent.position.distance_to(playerTargets[0].get_position()) < parent.rng: 
			print("is this working?")
			Transitioned.emit(self,"enemy_attack")
	if parent.currentHP <= 0:
		Transitioned.emit(self,"death")

func _on_health_component_damage_hurt():
	Transitioned.emit(self,"enemy_hurt")
func _on_health_component_damage_blocked():
	Transitioned.emit(self,"enemy_block")
func _on_enemy_detector_body_entered(body):
	print(body.name + " has entered range")
	if body.is_in_group("enemy_player"):
		print("Player spotted! ", body)
		playerTargets.append(body)

