extends State
class_name idle
@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var sprite = get_node("../../Sprite2D")

@export var parent: CharacterBody2D
@onready var target = parent.position

var enemies= []

func Enter():
	print("Idle state")
	animationPlayer.play("idle")
	parent.velocity.x = 0

func _input(event: InputEvent):
	if event.is_action_pressed("right_click"):
			parent.toggle_cursor_state(true)
			Transitioned.emit(self,"walk")
	if event.is_action_released("right_click"):
			parent.toggle_cursor_state(false)
	return null
func Physics_Update(_delta):
	if enemies.size() > 0:
		if parent.position.distance_to(enemies[0].get_position()) < parent.rng: 
			#Transitioned.emit(self,"attack")
			pass
	
func Update(_delta):
	if parent.currentHP <= 0:
		Transitioned.emit(self,"death")
func _on_health_component_damage_hurt():
	Transitioned.emit(self,"hurt")
func _on_health_component_damage_blocked():
	Transitioned.emit(self,"block")
func _on_enemy_detector_body_entered(body):
	print(body.name + " has entered range")
	if body.is_in_group("enemy"):
		print("You are my enemy! ", body)
		enemies.append(body)
