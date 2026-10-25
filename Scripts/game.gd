extends Node2D

var water := preload("res://Scenes/water.tscn")
var rock := preload("res://Scenes/rock.tscn")	

var shield := preload("res://Scenes/shield.tscn")
var magnet := preload("res://Scenes/magnet.tscn")
var shrinker := preload("res://Scenes/shrinker.tscn")
var star:= preload("res://Scenes/super_star.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Bg2/AnimationPlayer.play("bg")
	GlobalVariables.death = false
	GlobalVariables.moisture = 100.0
	$Overlays/GameOver.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Overlays/ProgressBar.value = GlobalVariables.moisture
	$Overlays/DepthMeter.text = str(roundi(GlobalVariables.depth)) + " m"
	
	if GlobalVariables.death == true:
		$Timers/ObsTimer.stop()
		$Overlays/GameOver.show()
		$Overlays/GameOver/Label.text = "Final Depth: " + str(roundi(GlobalVariables.depth))
		


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
		
	if r < 0.3:
		new_pwr = shield.instantiate() # one time use shield
	elif 0.3 <= r and r < 0.6:
		new_pwr = magnet.instantiate() # attracts water
	elif 0.6 <= r and r < 0.9:
		new_pwr = shrinker.instantiate()
	else:
		new_pwr = star.instantiate() #equivalent of super star in mario or slightly worse lol
		
	new_pwr.position = Vector2(x_pos, y_pos)
	add_child(new_pwr)	
	
	


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
