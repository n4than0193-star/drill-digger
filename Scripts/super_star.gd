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
	
func _on_body_entered(body: CharacterBody2D) -> void:
	if body.name == "RootTip":
		var collision = get_node_or_null("CollisionShape2D")
		if collision:
			collision.set_deferred("disabled", true)
			
		GlobalVariables.star = true
		GlobalVariables.growth_speed = 450.0
		print("STAR :D")
		$ColorRect.hide()

		var global_timer := Timer.new()
		global_timer.wait_time = 5.0
		global_timer.one_shot = true
		global_timer.timeout.connect(func():
			GlobalVariables.star = false
			GlobalVariables.growth_speed = 150.0
			print("...no star... D:")
			global_timer.queue_free())
			
		get_tree().root.add_child(global_timer)
		global_timer.start()
		
		queue_free()



		
