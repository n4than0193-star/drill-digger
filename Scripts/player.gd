extends Node2D

@onready var trail: Line2D = $RootTip/ColorRect/RootTrail
@onready var tip: CharacterBody2D = $RootTip

var is_shrunk: bool = false
var original_tip_scale: Vector2
var original_trail_width: float

func _ready() -> void:
	tip.position = Vector2(576, 0) 
	original_tip_scale = tip.scale
	original_trail_width = trail.width
	trail.clear_points()
	trail.top_level = true

func _process(delta: float) -> void:
	$RootTip/ColorRect.play("default")

	GlobalVariables.moisture -= 4.0 * delta
	if GlobalVariables.death:
		print("Game Over! Final Depth: " + str(int(GlobalVariables.depth)))
		$RootTip/ColorRect.stop()
		$RootTip/ColorRect.self_modulate = Color8(255, 0, 0, 255)
		set_process(false)
		return
	
	var direction = Input.get_axis("Left", "Right")
	tip.velocity.x = direction * GlobalVariables.speed
	tip.move_and_slide()
	tip.position.x = clamp(tip.position.x, 304, 853)
	
	if direction == -1:
		tip.rotation = deg_to_rad(45)
	elif direction == 1:
		tip.rotation = deg_to_rad(-45)
	else:
		tip.rotation = 0
	
	if GlobalVariables.star == true:
		GlobalVariables.depth += GlobalVariables.growth_speed * delta * 0.3
	elif GlobalVariables.shrink == true:
		GlobalVariables.depth += GlobalVariables.growth_speed * delta * 0.2
		if not is_shrunk:
			tip.scale = original_tip_scale * 0.5
			trail.width = original_trail_width * 0.5
			is_shrunk = true
	else:
		GlobalVariables.depth += GlobalVariables.growth_speed * delta * 0.1
		if is_shrunk:
			tip.scale = original_tip_scale
			trail.width = original_trail_width
			is_shrunk = false
	
	var movement_offset = 150.0 * delta
	
	for i in range(trail.get_point_count()):
		var pos = trail.get_point_position(i)
		pos.y -= movement_offset
		trail.set_point_position(i, pos)
	
	if trail.get_point_count() > GlobalVariables.trail_size:
		trail.remove_point(0)
	
	var back_offset = Vector2.UP.rotated(tip.rotation) * 24.0
	var spawn_pos = tip.global_position + back_offset
	
	trail.add_point(spawn_pos)
