extends Node2D

@onready var player = %player
@onready var animation_player = $AnimationPlayer
@export var newWeapon = ""

func _on_change_weapon_area_body_entered(body):
	if(animation_player.current_animation != "emptyAlter"):
		player.changeWeapon(newWeapon)
		animation_player.play("emptyAlter")
