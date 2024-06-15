extends Node2D
@onready var animation_player = $AnimationPlayer
@export var lvl = ""
var doorState = 'closed'
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@onready var game_manager = $"../gameManager"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#animation_player.play(doorState)
@onready var player = $"../player"
func _on_area_2d_body_entered(_body):
	animation_player.play("openDoor")
	player.enterVisible(true)
	doorState = "opened"


func _physics_process(_delta):
	if(Input.is_action_just_pressed("attack") && doorState == 'opened'):
		get_tree().change_scene_to_file("res://scenes/lvls/" + str(lvl) + ".tscn")


func _on_area_2d_body_exited(_body):
	animation_player.play("CloseDoor")
	player.enterVisible(false)
	doorState = 'closed'
	print('playing close')
