extends State
class_name walk


@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var sprite = get_node("../../Sprite2D")

@export var parent: CharacterBody2D
@export var speed:int = 20

@onready var target = parent.position

func Enter():
	print("entered walk state")
	animationPlayer.play("walk")

func Physics_Update(delta):
	if parent.follow_cursor == true:
		target = parent.get_global_mouse_position()
	parent.velocity = parent.position.direction_to(target) * speed
	if parent.position.distance_to(target) > 10:
		if parent.position.x > target.x:
			sprite.flip_h = true
		elif parent.position.x <= target.x:
			sprite.flip_h = false
		parent.move_and_slide()
	return null
	


