extends Node2D

@onready var trail: Line2D = $RootTrail
@onready var tip: CharacterBody2D = $RootTip

var moisture = 100.0 #health var
var depth: float = 0.0 #sorta like a timer for the game
var growth_speed: float = 150.0 #constant speed at ehich the root descends
var speed: float = 300.0 #speed at which the root goes left/right

func _ready() -> void:
	tip.position = Vector2(576, 150)
	trail.clear_points()

func _process(delta: float) -> void:
	moisture -= 5.0 * delta
	if moisture <= 0.0:
		print("Game Over! Final Depth: " + str(depth))
		set_process(false)
	
	var direction = Input.get_axis("Left", "Right")
	tip.velocity.x = direction * speed
	tip.move_and_slide()
	
	tip.position.x = clamp(tip.position.x, 10, 1142)
	
	depth += growth_speed
	
	
	
		
