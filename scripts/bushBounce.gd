extends RigidBody2D

var bouncesLeft = 10
var velocity = Vector2()
var rand = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	if(rand.randf_range(0.0, 2.0) <=1):
		velocity = Vector2(5,-12)
	else:
		velocity = Vector2(-5,-12)
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotation += 20 * delta
	var collision_info = move_and_collide(velocity)
	if( collision_info):
		if(velocity.length() == 0):
			velocity = Vector2(-5,-12)
		velocity = velocity.bounce(collision_info.get_normal())
		velocity = velocity.limit_length(100)





func _on_area_2d_area_entered(area):
	print('bounce')
	bouncesLeft -=1
	if(bouncesLeft <= 0):
		queue_free()



func _on_area_2d_body_entered(body):
	print('bounce')
	bouncesLeft -=1
	if(bouncesLeft <= 0):
		queue_free()

func _on_player_hurt_area_area_entered(area):
	player.treeHit()
	print('bush hit')

@onready var player = $"../../player"

func _on_player_hurt_area_body_entered(body):
	player.treeHit()

	print('bush hit')
