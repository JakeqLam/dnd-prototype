extends Area2D

var dmg:int = 1
var spd:int = 1
@export var projectileType: Node2D

func _ready():
	dmg = projectileType.dmg
	spd = projectileType.spd

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += spd * direction * delta
func generateDMG(dmgMin, dmgMax):
		dmg = randi_range(dmgMin, dmgMax)
		return dmg
func destroy():
	queue_free()
func _on_area_entered(_area):
	destroy()
func _on_body_entered(_body):
	destroy()
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
