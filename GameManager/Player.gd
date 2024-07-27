extends Node2D

var playerUnits = []
# Instantiate ALL Player Units under this node
# Add all Player units to a Player controlled group
func _ready():
	playerUnits = self.get_children()
	
	for player in playerUnits:
		player.set_player(true)
		player.add_to_group("playerUnits")
	
	
	
