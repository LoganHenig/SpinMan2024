extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer
@onready var animation_player = $AnimatedSprite2D/AnimationPlayer

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var upDraftBool = false
var dashBool = "ready"
var jumpsLeft = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	
	#Animation
	if direction == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")
	
	
	if not is_on_floor():
		velocity.y += gravity * delta
		if(animated_sprite.flip_h == true):
			animated_sprite.rotation += 25 * delta
		else:
			animated_sprite.rotation += 25 * delta * -1
	else:
		jumpsLeft = 2
		if(dashBool == "waiting"):
			dashBool="ready"
			print('ready')
		animated_sprite.rotation = 0
		
		if(direction > 0):
			animated_sprite.flip_h = false
		elif(direction < 0):
			animated_sprite.flip_h = true
	if Input.is_action_just_pressed("jump") and jumpsLeft > 0:
			jumpsLeft -= 1
			velocity.y = JUMP_VELOCITY	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if(Input.is_action_just_pressed("dash") && dashBool == "ready"):
		velocity.x += 1500 * direction
		dashBool = "used"
		print('dash')
		timer.start()
	if(upDraftBool):
		velocity.y += -20 
	
	if(Input.is_action_just_pressed("attack")):
		if(animated_sprite.flip_h == false):
			animation_player.play("slash")
		else:
			animation_player.play("slashL")
		
	
	move_and_slide()
func upDraft(tf):
	upDraftBool = tf
	print(tf)

func _on_timer_timeout():
	if(dashBool == "used"):
		dashBool = "waiting"
		
@onready var enter_sprite = $enterSprite
func enterVisible(animationBool):
	if(animationBool):
		enter_sprite.play("EnterVisible")
	else:
		enter_sprite.play("EnterNotVisible")
		
