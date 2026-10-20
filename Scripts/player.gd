extends Node2D

@onready var trail: Line2D = $RootTip/ColorRect/RootTrail
@onready var tip: CharacterBody2D = $RootTip

func _ready() -> void:
	tip.position = Vector2(576, 0) 
	trail.clear_points()

func _process(delta: float) -> void:
	GlobalVariables.moisture -= 5.0 * delta
	if GlobalVariables.death:
		print("Game Over! Final Depth: " + str(int(GlobalVariables.depth)))
		set_process(false)
	
	var direction = Input.get_axis("Left", "Right")
	tip.velocity.x = direction * GlobalVariables.speed
	tip.move_and_slide()
	print(str(direction))
	tip.position.x = clamp(tip.position.x, 10, 1142)
	
	GlobalVariables.depth += GlobalVariables.growth_speed * delta
	
	if not GlobalVariables.death:	
		for i in range(trail.get_point_count()):
			var pos = trail.get_point_position(i)
			pos.y -= GlobalVariables.growth_speed * delta
			trail.set_point_position(i, pos)
		
		if trail.get_point_count() > GlobalVariables.trail_size:
			trail.remove_point(0)
		
		trail.add_point(tip.global_position)
	
	if GlobalVariables.death == true:
			$RootTip/ColorRect.color = Color8(255,0,0,255) #replace w death anim
			
		
