extends State
class_name idle
@onready var animationPlayer = get_node("../../AnimationPlayer")

@export var parent: CharacterBody2D
@onready var target = parent.position

var enemyTargets = []

func Enter():
	enemyTargets = get_tree().get_nodes_in_group("EnemyTargets")
	animationPlayer.play("idle")
	parent.velocity.x = 0

func _input(event: InputEvent):
	if event.is_action_pressed("right_click"):
			parent.toggle_cursor_state(true)
			if parent.isDead == false:
				Transitioned.emit(self,"walk")
	if event.is_action_released("right_click"):
			parent.toggle_cursor_state(false)
	return null
func Physics_Update(_delta):
	if enemyTargets.size() > 0:
		if parent.isDead == false and parent.position.distance_to(enemyTargets[0].get_position()) < parent.wpnRange:
			Transitioned.emit(self,"attack")
	
func Update(_delta):
	if parent.isDead == true:
		Transitioned.emit(self,"death")
func _on_health_component_damage_hurt(_dmg):
	if parent.isDead == false:
		Transitioned.emit(self,"hurt")
func _on_health_component_damage_blocked():
	if parent.isDead == false:
		Transitioned.emit(self,"block")
func _on_enemy_detector_body_entered(body):
	if body.is_in_group("enemy"):
		body.add_to_group("EnemyTargets")

