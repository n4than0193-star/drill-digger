extends Node2D

var water: PackedScene = preload("res://Scenes/water.tscn")
var rock: PackedScene = preload("res://Scenes/rock.tscn")	

@onready var spawn_timer:Timer = $ObsTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.depth > 1250000:
		$ColorRect.color = Color8(39, 20, 29, 255)
	
	elif GlobalVariables.depth > 1000000:
		$ColorRect.color = Color8(71, 39, 47, 255)
	
	elif GlobalVariables.depth > 750000:
		$ColorRect.color = Color8(84, 49, 40, 255)
	
	elif GlobalVariables.depth > 500000:
		$ColorRect.color = Color8(93, 51, 45, 255)
	
	elif GlobalVariables.depth > 250000:
		$ColorRect.color = Color8(103, 53, 54, 255)
	
	else:
		$ColorRect.color = Color8(133, 74, 55, 255)
		
	$CanvasLayer/ProgressBar.value = GlobalVariables.moisture
	$CanvasLayer/ProgressBar.position.x = ($Player.position.x - 30) * delta


func _on_obs_timer_timeout() -> void:
	var x_pos: float = randf_range(50, 1100)
	var y_pos: float = 700.0
	var new_obst 	
	
	if randf() < 0.4:
		new_obst = rock.instantiate()	
	else:
		new_obst = water.instantiate()
	
	new_obst.position = Vector2(x_pos, y_pos)
	add_child(new_obst)
