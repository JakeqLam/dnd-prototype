extends Area2D

@export var parent:CharacterBody2D
var dmg:int = 0

func _ready():
	dmg = generateDMG(parent.wpnDmgMin, parent.wpnDmgMax)

func generateDMG(dmgMin, dmgMax):
		dmg = randi_range(dmgMin, dmgMax)
		return dmg
