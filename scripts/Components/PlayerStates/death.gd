extends State
class_name death
@onready var animationPlayer = get_node("../../AnimationPlayer")

func Enter():
	animationPlayer.play("death")
	
func Physics_Update(_delta):
	return null
