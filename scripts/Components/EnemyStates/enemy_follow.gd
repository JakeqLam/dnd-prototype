extends State
class_name EnemyFollow

@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var sprite = get_node("../../Sprite2D")

@export var parent: CharacterBody2D
@export var speed:int = 20

@onready var target = parent.position

func Enter():
	print("walk state")
	animationPlayer.play("walk")

func Update(_delta):
	if parent.currentHP <= 0:
		Transitioned.emit(self,"death")

func Physics_Update(_delta):

	if parent.follow_cursor == true:
		target = parent.get_global_mouse_position()
	
	var direction =  parent.global_position - target
	parent.velocity = parent.position.direction_to(target) * speed
	
	if parent.position.distance_to(target) > 1:
		if parent.position.x > target.x:
			sprite.flip_h = true
		elif parent.position.x <= target.x:
			sprite.flip_h = false
		parent.move_and_slide()
	
	if direction.length() < 1:
		Transitioned.emit(self, "idle")
	return null

func _on_health_component_damage_hurt():
	Transitioned.emit(self,"hurt")
func _on_health_component_damage_blocked():
	Transitioned.emit(self,"block")
