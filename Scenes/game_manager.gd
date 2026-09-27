extends Node

@onready var player_1: CharacterBody2D = $"../Player1"
@onready var player_2: CharacterBody2D = $"../Player2"


@onready var scorelabel_2: Label = %scorelabel2
@onready var scorelabel_1: Label = %scorelabel1
@onready var tag_1: Label = %Tag1
@onready var tag_2: Label = %Tag2
@onready var tag_3: Label = %Tag3
@onready var tag_time: Label = $TagTime

@onready var timer: Timer = $Timer
@onready var timer_2: Timer = $Timer2

@onready var rigid_body_2d: RigidBody2D = %RigidBody2D

@export var ball_speed = 700

@export var speedup_scale = 1.15

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready() -> void:
	tag_time.text = str(int(roundf(timer.get_time_left()))) #just to print "60" at start
	

	
	# 1. Force the banner to show the starting message
	tag_3.text = "PRESS SPACE TO START"
	# 2. Freeze the ball instantly so it doesn't move yet
	rigid_body_2d.freeze = true
	# 3. Ensure the timer is stopped
	timer.stop()
	pass

func _input(event: InputEvent) -> void:
	#control start or restart game
	if event.is_action_pressed("start_game") and not Global.game_started :
		Global.game_started = true
		tag_3.text = ""
		
		#move the paddles back to center
		player_1.position = Vector2(87,564)
		player_2.position = Vector2(1823,564)
		
		rigid_body_2d.freeze = false
		
		var x = randi_range(-900, 900) 
		rigid_body_2d.linear_velocity = Vector2(700, x )
		rigid_body_2d.global_transform.origin =Vector2(960, 550)# Teleport to center

		timer.start()
		
		audio_stream_player_2d.play()
	
		score1 = 0
		score2 = 0
		scorelabel_1.text = "0"
		scorelabel_2.text = "0"
		pass
	
func _process(delta: float) -> void:

	pass	
	

var score1 = 0
var score2 = 0

func speed_up():
		rigid_body_2d.linear_velocity *= speedup_scale # ball gets faster every paddlehit
		print("speed up")


func add_point1():
	score1+=1
	print("add score for player 1")
	scorelabel_1.text = str(score1)
	
func add_point2():
	score2+=1
	print("add score for player 2")
	scorelabel_2.text = str(score2)	
	


func _on_timer_timeout() -> void:
	audio_stream_player_2d.stream_paused = true
	
	#freeze the ball
	rigid_body_2d.freeze = true
	if score1 > score2 :
		print("player 1 wins")
		tag_3.text = "player 1 wins"
	elif score1 < score2 :
		print("player 2 wins")
		tag_3.text = "player 2 wins"
	else :
		print("draw")
		tag_3.text = "draw"
		
		
	timer.stop()
	#stop the game timer

	await get_tree().create_timer(4.0).timeout# a 4s timeout
	
	tag_3.text = "PRESS SPACE TO PLAY AGAIN"
	Global.game_started = false
	#await get_tree().create_timer(2.0).timeout# a 2s timeout
	

	pass # Replace with function body.


func _on_killzone_1_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		rigid_body_2d.set_deferred("freeze", true)
		timer.paused = true
		rigid_body_2d.set_deferred("freeze", false) #unfreeze the ball
		await get_tree().create_timer(1.0).timeout# a 5s timeout
		rigid_body_2d.global_transform.origin =Vector2(960, 550)# Teleport to center
		#rigid_body_2d.global_position = Vector2(576, 324) # Teleport to center
		var x = randi_range(-900, 900) 
		rigid_body_2d.linear_velocity = Vector2(ball_speed, x)	
		
		timer.paused = false
		

	
	pass # Replace with function body.


func _on_killzone_2_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		rigid_body_2d.set_deferred("freeze", true)
		timer.paused = true
		await get_tree().create_timer(1.0).timeout# a 5s timeout
		rigid_body_2d.set_deferred("freeze", false)#unfreeze the ball
		rigid_body_2d.global_transform.origin =Vector2(960, 550)# Teleport to center
		#rigid_body_2d.global_position = Vector2(576, 324) # Teleport to center
		var x = randi_range(-900, 900) 
		rigid_body_2d.linear_velocity = Vector2(-ball_speed, x)	
		timer.paused = false


	pass # Replace with function body.

#print time left
#restart 1s timer to print again
func _on_timer_2_timeout() -> void:
	if Global.game_started :
		tag_time.text = str(int(roundf(timer.get_time_left())))
		pass # Replace with function body.
