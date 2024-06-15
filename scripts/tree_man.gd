extends CharacterBody2D

@onready var player = $"../player"
@onready var eyes = $Eyes
@onready var timer = $Timer
@onready var trunk_animation = $trunkAnimation
@onready var root_animation = $RootAnimation
const BUSH_BOUNCE = preload("res://scenes/bushBounce.tscn")

var timerStarted = false
@onready var bush_timer = $bushTimer

var state = "followPlayer"
var player_position
var target_position
var speed= 100
var rand = RandomNumberGenerator.new()
var timerSet = false
var health = 135

# Called when the node enters the scene tree for the first time.
func setTimer():
	timer.wait_time = rand.randf_range(1.0, 4.0)
	timerSet = true
	timer.start()
func _ready():
	startMyTimer()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	#eyeTrackingLogiv
	if(player.position.x > position.x):
		eyes.flip_h = true
	else:
		eyes.flip_h = false
	if(state == "followPlayer"):
		position.x += (player.position.x - position.x)/speed
		

func _on_timer_timeout():
	root_animation.play("attack")
	print('attacking')

	
func startMyTimer():
	setTimer()
	timer.start()

func _on_root_area_body_entered(body):
	player.treeHit()


func _on_trunk_hit_area_area_entered(area):
	print(health)
	print("health^")
	if ( health <= 120 && !timerStarted):
		bush_timer.start()
		timerStarted = true
	health -= 1
	if(health <= 0):
		trunk_animation.play("death")
		root_animation.play("DeadRoots")
		state = "dead"
		timer.stop()
		bush_timer.stop()
	else:
		trunk_animation.play('treeHit')


var bushSpray = 2
func _on_bush_timer_timeout():
	if(bushSpray > 0):
		bushSpray -= 1
		bush_timer.wait_time=.5		
		var bush = BUSH_BOUNCE.instantiate()
		add_child(bush)
	else:
		if(health < 40):
			bush_timer.wait_time = 3
			bushSpray = 4
		elif(health < 80):
			bush_timer.wait_time = 4
			bushSpray = 3
		else:
			bush_timer.wait_time = 5
			bushSpray = 2
	bush_timer.start()
			
