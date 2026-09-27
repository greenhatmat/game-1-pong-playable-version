extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D :
		get_node("/root/Game/GameManager").speed_up() 
	pass # Replace with function body.
