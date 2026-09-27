extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		get_node("/root/Game/GameManager").add_point1() 
		# call function from another script/scene
