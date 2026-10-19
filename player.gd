extends Node2D

@onready var trail: Line2D = $RootTip/ColorRect/RootTrail
@onready var tip: CharacterBody2D = $RootTip

func _ready() -> void:
	tip.position = Vector2(576, 0)
	trail.clear_points()

func _process(delta: float) -> void:
	GlobalVariables.moisture -= 5.0 * delta
	if GlobalVariables.moisture <= 0.0:
		print("Game Over! Final Depth: " + str(GlobalVariables.depth))
		set_process(false)
	
	var direction = Input.get_axis("Left", "Right")
	tip.velocity.x = direction * GlobalVariables.speed
	tip.move_and_slide()
	tip.position.x = clamp(tip.position.x, 10, 1142)
	
	GlobalVariables.depth += GlobalVariables.growth_speed
		
	for i in range(trail.get_point_count()):
		var pos = trail.get_point_position(i)
		pos.y -= GlobalVariables.growth_speed * delta
		trail.set_point_position(i, pos)
		
	if trail.get_point_count() > GlobalVariables.trail_size:
		trail.remove_point(0)
		
	
	trail.add_point(tip.position)
	
		
