extends CharacterBody2D

@export var speed: int = 50
@onready var animations =  $AnimationPlayer
@onready var sounds = $AudioStreamPlayer2D
@onready var playersprite = Sprite2D
@onready var particleEmitter = CPUParticles2D

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection*speed

	if Input.is_action_pressed("sprint"): #Makes the player run
		speed = 200
		animations.speed_scale = 2
	else:
		speed = 100
		animations.speed_scale = 1

func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		
		animations.play("walk" + direction)
	

#func sprintEmitter():
#	if animations.speed_scale == 2:
#		particleEmitter.show()
#	else:
#		particleEmitter.hide()

func hotKeys():
	if Input.is_action_pressed("escape"): #Will quit game if pressed
		get_tree().quit()

func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()
	hotKeys()
	#sprintEmitter()
