extends CharacterBody2D

@export var speed: int = 600


func _physics_process(delta: float) -> void:
	
	if not Global.game_started :
		return # if the game isnt started, no movement, immediately return
	
	var direction = Input.get_vector("left1", "right1", "up1", "down1")
	velocity = direction * speed
	velocity.x = 0
	move_and_slide()
