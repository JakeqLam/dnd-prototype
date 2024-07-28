extends State
class_name idle
@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var sprite = get_node("../../Sprite2D")

@export var parent: CharacterBody2D

@onready var target = parent.position

func Enter():
	print("entered idle state")
	animationPlayer.play("idle")
	parent.velocity.x = 0

func _input(event: InputEvent):
	if event.is_action_pressed("right_click"):
			print("right click!")
			parent.toggle_cursor_state(true)
			Transitioned.emit(self,"walk")
	if event.is_action_released("right_click"):
			parent.toggle_cursor_state(false)
	return null

func Physics_Update(delta):
	return null
