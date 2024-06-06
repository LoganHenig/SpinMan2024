extends Node

@onready var score_label = $"../player/scoreLabel"
@onready var animation_player = $"../Platforms/Gate/AnimationPlayer"
@onready var game_manager = $gameManager


@export var lvl = ""

var score = 0
@export var total: int = 100


func foundCoin():
	score += 1
	if(score >= total):
		score_label.text = "SICK!"
		animation_player.play("completeLvl")
	else:
		score_label.text = str(score) + "/" + str(total)



func nextLvlCall():
	get_tree().change_scene_to_file("res://scenes/lvls/" + str(lvl))

