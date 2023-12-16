extends CharacterBody2D

@export var speed: int = 50
@onready var animations =  $AnimationPlayer

@onready var sounds = $AudioStreamPlayer2D
@onready var playersprite = Sprite2D
@onready var particleEmitter = CPUParticles2D

@onready var hurtColor = $Sprite2D/ColorRect

@export var maxHealth = 3
@onready var currentHealth: int = maxHealth


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

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		


func _physics_process(delta):
	handleInput()
	move_and_slide()
	handleCollision()
	updateAnimation()

	hotKeys()
	#sprintEmitter()



func _on_hurt_box_area_entered(area):
	if area.name == "hitBox":
		currentHealth -= 1
		if currentHealth < 0:
			currentHealth = maxHealth
		print_debug(currentHealth)

