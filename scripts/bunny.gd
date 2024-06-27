extends RigidBody2D

@onready var bunny_animation_player = $bunnyAnimationPlayer
@onready var attack_area = $attackArea
@onready var timer = $Timer
@onready var player = %player
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var left_ray = $leftRay
@onready var right_ray = $rightRay

var velocity = Vector2()
var state = "idle"
var rand = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	bunny_animation_player.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(player.global_position.x > self.global_position.x):
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false



func _on_attack_area_body_entered(body):
	if(state == "idle"):
		state = "prePounce"
		bunny_animation_player.play("prePounce")
		timer.start()

func _physics_process(delta):
	rotation = 0
	move_and_collide(velocity)

func _on_timer_timeout():
	bunny_animation_player.play("pounce")
	state = "pounce"
	if(player.global_position.x > self.global_position.x):
		if(right_ray.is_colliding()):
			velocity = Vector2(-3,-2)		
			timer.wait_time = .2
			
		else:
			velocity = Vector2(rand.randf_range(3.0, 5.0),-rand.randf_range(7.0, 9.0))
			timer.wait_time = .7
	else:
		if(left_ray.is_colliding()):
			velocity = Vector2(3,-2)
			timer.wait_time = .2
		else:
			velocity = Vector2(-rand.randf_range(3.0, 5.0),-rand.randf_range(7.0, 9.0))
			timer.wait_time = .7
	


func _on_ground_detection_area_body_entered(body):
	if(state=="pounce"):
		print("landed")
		timer.stop()
		state = 'prePounce'
		velocity = Vector2(0,0)
		bunny_animation_player.play("prePounce")

		timer.start()


func _on_ground_detection_area_body_exited(body):
	pass # Replace with function body.




func _on_death_area_area_entered(area):
	state = 'dead'
	bunny_animation_player.play("death")
