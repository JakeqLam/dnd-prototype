extends Node
class_name VFXSpawner
#All VFX for a sprite
@export var EFFECT_HIT: PackedScene
@export var DEATH_HIT: PackedScene
@export var parent:CharacterBody2D

const INDICATOR_DAMAGE = preload("res://UI/DamageIndicator.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn_effect(EFFECT: PackedScene, effect_position: Vector2 = parent.global_position):
	if EFFECT:
		var effect = EFFECT.instantiate()
		get_tree().current_scene.add_child(effect)
		effect.global_position = effect_position
		return effect

func spawn_dmgIndicator(damage: int):
	var indicator = spawn_effect(INDICATOR_DAMAGE)
	if indicator:
		indicator.label.text = str(damage)
