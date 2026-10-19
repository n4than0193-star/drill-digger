extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.depth > 125000:
		$ColorRect.color = Color8(39, 20, 29, 255)
	
	elif GlobalVariables.depth > 100000:
		$ColorRect.color = Color8(71, 39, 47, 255)
	
	elif GlobalVariables.depth > 75000:
		$ColorRect.color = Color8(84, 49, 40, 255)
	
	elif GlobalVariables.depth > 50000:
		$ColorRect.color = Color8(93, 51, 45, 255)
	
	elif GlobalVariables.depth > 25000:
		$ColorRect.color = Color8(103, 53, 54, 255)
