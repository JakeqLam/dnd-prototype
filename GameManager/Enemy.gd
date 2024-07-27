extends Node2D

var enemyUnits = []
# Instantiate ALL enemy Units under this node
# Add all enemy units to an enemy group
func _ready():
	enemyUnits = self.get_children()
	
	for enemy in enemyUnits:
		enemy.set_player(false)
		enemy.add_to_group("enemyUnits")
	
	
	
