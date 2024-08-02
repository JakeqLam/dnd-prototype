extends State
class_name idle
@onready var animationPlayer = get_node("../../AnimationPlayer")
@onready var playerController = get_node("../../PlayerController")

var player: CharacterBody2D
#@onready var target = player.position

var enemyTargets = []
func _ready():
	player = playerController.getCharacterBody()
func Enter():
	enemyTargets = get_tree().get_nodes_in_group("EnemyTargets")
	animationPlayer.play("idle")
	player.velocity.x = 0
	player.velocity.y = 0
func _input(event: InputEvent):
	if event.is_action_pressed("right_click"):
			player.toggle_cursor_state(true)
			if player.isDead == false:
				Transitioned.emit(self,"walk")
	if event.is_action_released("right_click"):
			player.toggle_cursor_state(false)
	return null

func Physics_Update(_delta):
	if enemyTargets.size() > 0:
		if player.isDead == false and player.position.distance_to(enemyTargets[0].get_position()) < player.wpnRange:
			Transitioned.emit(self,"attack")
	
func Update(_delta):
	if player.isDead == true:
		Transitioned.emit(self,"death")
func _on_health_component_damage_hurt(_dmg):
	if player.isDead == false:
		Transitioned.emit(self,"hurt")
func _on_health_component_damage_blocked():
	if player.isDead == false:
		Transitioned.emit(self,"block")
func _on_enemy_detector_body_entered(body):
	if body.is_in_group("enemy"):
		body.add_to_group("EnemyTargets")

