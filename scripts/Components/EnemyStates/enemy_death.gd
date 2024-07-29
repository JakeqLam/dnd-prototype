extends State
class_name EnemyDeath
@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var sprite = get_node("../../Sprite2D")

func Enter():
	print("death state")
	animationPlayer.play("death")
	
func Physics_Update(_delta):
	return null
