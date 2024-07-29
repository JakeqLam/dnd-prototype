extends State
class_name EnemyIdle
@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var sprite = get_node("../../Sprite2D")

@export var parent: CharacterBody2D
@onready var target = parent.position

func Enter():
	print("Idle state")
	#animationPlayer.play("idle")
	parent.velocity.x = 0


func Update(_delta):
	animationPlayer.play("attack01")
	if parent.currentHP <= 0:
		Transitioned.emit(self,"death")

func _on_health_component_damage_hurt():
	Transitioned.emit(self,"hurt")
func _on_health_component_damage_blocked():
	Transitioned.emit(self,"block")
