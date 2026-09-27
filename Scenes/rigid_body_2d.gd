extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var x = randi_range(-900, 900) 
	
	linear_velocity = Vector2(700, x )
	pass # Replace with function body.
