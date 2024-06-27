extends Node2D

@export var music2Play=""

# Called when the node enters the scene tree for the first time.
func _ready():
	var soundManager =  get_node("/root/SoundManager")
	soundManager.playSong(music2Play)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
