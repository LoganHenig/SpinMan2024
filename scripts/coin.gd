extends Area2D
@onready var game_manager = $"../../gameManager"
@onready var animation_player = $AnimationPlayer
@export var collectable = true

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D



func toggleCollectable():
	animated_sprite_2d.visible = !animated_sprite_2d.visible
	collision_shape_2d.disabled = !collision_shape_2d.disabled
	

func _on_body_entered(_body):
	print("coin collected")
	game_manager.foundCoin()
	animation_player.play("pickup")


func _on_ready():
	animated_sprite_2d.visible = collectable
	collision_shape_2d.disabled = !collectable
