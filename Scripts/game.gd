extends Node2D

var water := preload("res://Scenes/water.tscn")
var rock := preload("res://Scenes/rock.tscn")	

var shield := preload("res://Scenes/shield.tscn")
var speed: PackedScene
var powerup_no3
var star: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.depth > 25000:
		$ColorRect.color = Color8(39, 20, 29, 255)
	
	elif GlobalVariables.depth > 20000:
		$ColorRect.color = Color8(71, 39, 47, 255)
	
	elif GlobalVariables.depth > 15000:
		$ColorRect.color = Color8(84, 49, 40, 255)
	
	elif GlobalVariables.depth > 10000:
		$ColorRect.color = Color8(93, 51, 45, 255)
	
	elif GlobalVariables.depth > 5000:
		$ColorRect.color = Color8(103, 53, 54, 255)
	
	else:
		$ColorRect.color = Color8(133, 74, 55, 255)
		
	$CanvasLayer/ProgressBar.value = GlobalVariables.moisture
	
	if GlobalVariables.death == true:
		$Timers/ObsTimer.stop()


func _on_obs_timer_timeout() -> void:
	var x_pos := randf_range(50, 1100)
	var y_pos := 700.0
	var new_obst 	
	
	if randf() < 0.4:
		new_obst = rock.instantiate()	
	else:
		new_obst = water.instantiate()
	
	new_obst.position = Vector2(x_pos, y_pos)
	add_child(new_obst)

func _on_pwr_timer_timeout() -> void:
	var x_pos := randf_range(50, 1100)
	var y_pos := 700.0
	var new_pwr
	var r: float = randf()
	
	if r < 0.3:
		new_pwr = shield.instantiate() # one time use shield
	elif 0.3 <= r and r < 0.6:
		new_pwr = shield.instantiate() # speed buff
	elif 0.6 <= r and r < 0.9:
		new_pwr = shield.instantiate() # moisture goes up temporarily (pretty bad, will think of new one)
	else:
		new_pwr = shield.instantiate() #equivalent of super star in mario
		
	new_pwr.position = Vector2(x_pos, y_pos)
	add_child(new_pwr)	
	
