extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not GlobalVariables.death:
		position.y -= GlobalVariables.growth_speed * delta
	
	if position.y < -1000:
		queue_free()
	
func die():
	queue_free()

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.name == "RootTip":
		GlobalVariables.magnet = true
		print("Magnet On")
		$ColorRect.hide()
		await get_tree().create_timer(5.0).timeout
		GlobalVariables.magnet = false
		print("Magnet Off")
		die()
		
