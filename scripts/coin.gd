extends Area2D
@onready var game_manager = $"../../gameManager"
@onready var animation_player = $AnimationPlayer


func _on_body_entered(body):
	print("coin collected")
	game_manager.foundCoin()
	animation_player.play("pickup")
