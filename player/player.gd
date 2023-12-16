extends CharacterBody2D

@export var speed: int = 50
@onready var animations =  $AnimationPlayer

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection*speed

	if Input.is_action_pressed("sprint"): #Makes the player run
		speed = 100
	else:
		speed = 50

	
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
	


func hotKeys():
	if Input.is_action_pressed("escape"): #Will quit game if pressed
		get_tree().quit()

func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()
	hotKeys()
