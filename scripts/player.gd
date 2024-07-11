extends CharacterBody2D

@onready var timer = $Timer
@onready var animated_sprite = $bodyAnimatedSprite

@onready var death_timer = $DeathTimer
@onready var body_animation_player = $BodyAnimationPlayer
@onready var sword_animation_player = $SwordAnimationPlayer

@onready var running_particles = $runningParticles

@onready var dash_length = $dashLength
@onready var dashcool_down = $dashcoolDown

const SPEED = 255.0
const JUMP_VELOCITY = -450.0
var upDraftBool = false
var dashBool = "ready"
var jumpsLeft = 2
var currentSpeed = 0
var acc = 15
var weapon = ""


@export var health = 3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var direction = Input.get_axis("left", "right")

	if (Input.is_action_just_pressed("down")):
		set_collision_mask_value(9, false)
	if (Input.is_action_just_released("down")):
		set_collision_mask_value(9, true)
	#Animation
	if (direction == 0 && body_animation_player.current_animation != "hurt"):
#CREATE IDLE ANIMATION
		body_animation_player.play("idle")

	else:
		if(body_animation_player.current_animation != "hurt"):
			body_animation_player.play("run")
			
	
	
	if not is_on_floor():
		running_particles.emitting = false
		velocity.y += gravity * delta
		if(animated_sprite.flip_h == true):
			animated_sprite.rotation += 25 * delta
		else:
			animated_sprite.rotation += 25 * delta * -1
	else:
		jumpsLeft = 2
		if(dashBool == "waiting"):
			dashBool="ready"
		animated_sprite.rotation = 0
		

		if(direction > 0):
			animated_sprite.flip_h = false
			running_particles.emitting = true
			running_particles.direction.x = -1
		elif(direction < 0):
			animated_sprite.flip_h = true
			running_particles.emitting = true
			running_particles.direction.x = 1
		else:
			running_particles.emitting = false
	if Input.is_action_just_pressed("jump") and jumpsLeft > 0:
			jumpsLeft -= 1
			velocity.y = JUMP_VELOCITY	
	velocity.x = currentSpeed
	if direction:
		if((currentSpeed + direction*acc) >= -SPEED && (currentSpeed + direction*acc) <= SPEED):
			#boost for switching directions
			if((direction == 1 && currentSpeed < 0 ) || (direction == -1 && currentSpeed > 0)):
				currentSpeed += direction*acc*3
			elif((direction == 1 && currentSpeed < 150 ) || (direction == -1 && currentSpeed > -150)):
				currentSpeed += direction*acc*2
			else:
				currentSpeed += direction*acc
			
	else:
		if(currentSpeed < 0):
			currentSpeed += acc*2
		elif(currentSpeed > 0):
			currentSpeed -= acc*2
		elif(currentSpeed >= -15 && currentSpeed <= 15):
			currentSpeed = 0
	if(Input.is_action_just_pressed("dash") && dashBool == "ready"):
		velocity.x += 700 * direction
		#max speed in the direction of dash
		currentSpeed = SPEED*direction
		dashBool = "used"
		dash_length.start()
		dashcool_down.start()
	elif(dashBool == "used"):
		velocity.x += 700 * direction
	if(upDraftBool):
		velocity.y += -30 
	
	if(Input.is_action_pressed("attack")&& sword_animation_player.current_animation.find("slash") == -1	):
		if(animated_sprite.flip_h == false):
			print('made it here')
			sword_animation_player.play("slash" + weapon)
		else:
			sword_animation_player.play("slashL" + weapon)
		
	
	move_and_slide()
func upDraft(tf):
	upDraftBool = tf


func _on_timer_timeout():
	if(dashBool == "used"):
		dashBool = "waiting"
		
@onready var enter_sprite = $enterSprite
func enterVisible(animationBool):
	if(animationBool):
		enter_sprite.play("EnterVisible")
		print('visible')
	else:
		enter_sprite.play("EnterNotVisible")
	
func treeHit():
	health -= 1
	body_animation_player.play("hurt")
	print("hurt")
	if(health <= 0):
		Engine.time_scale = 0.5
		get_node("CollisionShape2D").queue_free()
		death_timer.start(1)


func _on_death_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()


func _on_dashcool_down_timeout():
	dashBool = "waiting"


func _on_dash_length_timeout():
	dashBool = "dashFinished"

func changeWeapon(newWeapon):
	weapon = newWeapon
	
