extends Node2D

var water := preload("res://Scenes/water.tscn")
var rock := preload("res://Scenes/rock.tscn")	

var shield := preload("res://Scenes/shield.tscn")
var magnet := preload("res://Scenes/magnet.tscn")
var star:= preload("res://Scenes/super_star.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.depth > 2500:
		$ColorRect.color = Color8(39, 20, 29, 255)
	
	elif GlobalVariables.depth > 2000:
		$ColorRect.color = Color8(71, 39, 47, 255)
	
	elif GlobalVariables.depth > 1500:
		$ColorRect.color = Color8(84, 49, 40, 255)
	
	elif GlobalVariables.depth > 1000:
		$ColorRect.color = Color8(93, 51, 45, 255)
	
	elif GlobalVariables.depth > 500:
		$ColorRect.color = Color8(103, 53, 54, 255)
	
	else:
		$ColorRect.color = Color8(133, 74, 55, 255)
		
	$Overlays/ProgressBar.value = GlobalVariables.moisture
	$Overlays/DepthMeter.text = str(roundi(GlobalVariables.depth)) + " m"
	
	if GlobalVariables.death == true:
		$Timers/ObsTimer.stop()
		$Overlays/GameOver.show()
		


func _on_obs_timer_timeout() -> void:
	var x_pos := randf_range(354.0, 204.0+590.0)
	var y_pos := 700.0
	var new_obst 	
	var is_overlapping := true
	var attempts := 0
	var max_attempts := 15
	var safe_buffer_distance := 70.0 

	
	while is_overlapping and attempts < max_attempts:
		is_overlapping = false 	
		var test_position := Vector2(x_pos, y_pos)
			
		for node in get_children():
			if node.is_in_group("spawned_items"):
				if test_position.distance_to(node.position) < safe_buffer_distance:
					is_overlapping = true
					break 
		attempts += 1
		
	if randf() < 0.8:
		new_obst = rock.instantiate()	
	else:
		new_obst = water.instantiate()
	
	new_obst.position = Vector2(x_pos, y_pos)
	add_child(new_obst)

func _on_pwr_timer_timeout() -> void:
	var x_pos := randf_range(354.0, 204.0+590.0)
	var y_pos := 700.0
	var new_pwr
	var r: float = randf()
	var is_overlapping := true
	var attempts := 0
	var max_attempts := 15
	var safe_buffer_distance := 70.0

	while is_overlapping and attempts < max_attempts:
		is_overlapping = false
		
		var test_position := Vector2(x_pos, y_pos)
		
		for node in get_children():
			if node.is_in_group("spawned_items"):
				if test_position.distance_to(node.position) < safe_buffer_distance:
					is_overlapping = true
					break
		attempts += 1
		
	if r < 0.4:
		new_pwr = shield.instantiate() # one time use shield
	elif 0.4 <= r and r < 0.8:
		new_pwr = magnet.instantiate() # attracts water
	else:
		new_pwr = star.instantiate() #equivalent of super star in mario or slightly worse lol
		
	new_pwr.position = Vector2(x_pos, y_pos)
	add_child(new_pwr)	
	
