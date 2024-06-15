extends Node2D

@onready var lvl_1_music = $lvl1Music
@onready var tree_music = $TreeMusic

var currentMusic = "lvl1"
# Called when the node enters the scene tree for the first time.
func _ready():
	lvl_1_music.play()

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func playSong(newAudio):
	if(currentMusic != newAudio):
		currentMusic = newAudio
		if(newAudio == "treeMan"):
			tree_music.play()
		else:
			tree_music.stop()
		if(newAudio == "lvl1"):
			lvl_1_music.play()
		else:
			lvl_1_music.stop()
			
