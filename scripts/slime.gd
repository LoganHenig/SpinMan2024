extends Node2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var slime_node = $"."
@onready var animation_player = $AnimationPlayer

const SPEED = 50

var direction = 1
var health = 2

func _process(delta):
	if(ray_cast_right.is_colliding()):
		direction = -1
		animated_sprite.flip_h = true
		
	elif(ray_cast_left.is_colliding()):
		direction = 1	
		animated_sprite.flip_h = false
	
	position.x += SPEED*delta*direction
	



func _on_area_2d_area_entered(area):
	if(health <= 1):
		animation_player.play("died")
	else:
		animation_player.play("hurt")
		health -= 1

	print("killed")
