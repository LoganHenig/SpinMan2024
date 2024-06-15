extends Node

@onready var score_label = $"../player/scoreLabel"
@onready var animation_player = $"../Platforms/Gate/AnimationPlayer"
@onready var game_manager = $gameManager


var score = 0
@export var total: int = 100

func _on_ready():
	score_label.text = "0/" + str(total)
	

func foundCoin():
	score += 1
	if(score >= total):
		score_label.text = "SICK!"
		animation_player.play("completeLvl")
	else:
		score_label.text = str(score) + "/" + str(total)








