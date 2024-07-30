extends State
class_name attack
@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var atkTimer = get_node("../../AttackSpeedTimer")
@export var atkSpd: float = 3.0
@export var parent: CharacterBody2D

var atkCooldown:bool = false

func Enter():
	print("Attack state")
	atkTimer.wait_time = atkSpd
	
	if atkCooldown == false:
		parent.velocity = Vector2(0,0)
		
		animationPlayer.play("attack01")
		atkTimer.start()
	elif atkCooldown == true:
		Transitioned.emit(self,"idle")

func _input(event: InputEvent):
	if event.is_action_pressed("right_click"):
			parent.toggle_cursor_state(true)
			Transitioned.emit(self,"walk")
	if event.is_action_released("right_click"):
			parent.toggle_cursor_state(false)
	return null

func Update(_delta):
	if parent.currentHP <= 0:
		Transitioned.emit(self,"death")

func _on_attack_speed_timeout():
	animationPlayer.play("attack01")
