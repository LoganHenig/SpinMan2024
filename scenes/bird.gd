extends Node2D
@onready var animation_bird = $"animation bird"

func _on_area_2d_area_entered(area):
	animation_bird.play("death")
