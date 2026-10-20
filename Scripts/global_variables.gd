extends Node

var moisture: float = 100.0 #health var
var depth: float = 0.0 #sorta like a timer for the game
var growth_speed: float = 150.0 #constant speed at ehich the root descends
var speed: float = 300.0 #speed at which the root goes left/right
var trail_size: float = 200 #size of root trail	 	
var death = false #self explanatory
var shield = false #checks whether invincible power-up is active

func _process(delta: float) -> void:
	if moisture > 100.0:
		moisture = 100.0 
	if moisture < 0.0:
		death = true
