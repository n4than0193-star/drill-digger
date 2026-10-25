extends Area2D

var is_dying: bool = false

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	if not GlobalVariables.death:
		position.y -= GlobalVariables.growth_speed * delta
	
	if position.y < -1000:
		queue_free()
	
func die() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "RootTip":
		var collision = get_node_or_null("CollisionShape2D")
		if collision:
			collision.set_deferred("disabled", true)
			
		GlobalVariables.shrink = true
		GlobalVariables.growth_speed = 300.0
		$ColorRect.hide()

		var global_timer := Timer.new()
		global_timer.wait_time = 5.0
		global_timer.one_shot = true
		global_timer.timeout.connect(func():
			GlobalVariables.shrink = false
			GlobalVariables.growth_speed = 150.0
			global_timer.queue_free())
			
		get_tree().root.add_child(global_timer)
		global_timer.start()
		
		queue_free()
