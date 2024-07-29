extends Node
class_name VFXSpawner
#All VFX for a sprite
@export var EFFECT_HIT: PackedScene
@export var DEATH_HIT: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn_effect(EFFECT: PackedScene, effect_position: Vector2):
	if EFFECT:
		var effect = EFFECT.instantiate()
		get_tree().current_scene.add_child(effect)
		effect.global_position = effect_position
