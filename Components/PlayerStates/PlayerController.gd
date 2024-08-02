extends Node
#This is an intermediate controller for the Player Characters.
#This is a middle communication point between the states and the logic
#Wire all components to this class
class_name PlayerController

#Wired up components
@export var player: CharacterBody2D
@export var animPlayer = AnimationPlayer
@export var hitbox = Area2D
@export var hurtbox = Area2D
@export var VFX: VFXSpawner

#Setting UI functions

#Moving functions

#Getters for all node references to the character
func getCharacterBody():
	return player
func getAnimPlayer():
	return animPlayer
func getHitbox():
	return hitbox
func getHurtbox():
	return hurtbox
func getVFXSpawner():
	return VFX

