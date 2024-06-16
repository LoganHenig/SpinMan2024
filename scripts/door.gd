extends Node2D
@onready var animation_player = $AnimationPlayer
@export var lvl = ""
var disabled = false

@export var CurrentLvl = ""
@export var NextLvl = ""
var doorState = 'closed'

var saveFilePath = "user://save/"
var saveFileName = "PlayerProgress.tres"
var playerProgress = null
#var progressData = preload("res://scripts/progressData.gd").new() #ProgressData.new())
# Called when the node enters the scene tree for the first time.
func _ready():
	verifySaveDirectory(saveFilePath)
	if ( ResourceLoader.exists( saveFilePath + saveFileName ) ):
		LoadData()
		if(playerProgress is ProgressData):
			print('good data')
	#checking if door should be disabled
		disabled = !playerProgress.checkLvl(CurrentLvl)
		if(disabled == true):
			animation_player.play("disabled")
	else: 
		playerProgress = ProgressData.new()
		disabled = !playerProgress.checkLvl(CurrentLvl)
		if(disabled == true):
			animation_player.play("disabled")



	#else:
		#print('in else')
	#playerProgress = LoadData()
	
func verifySaveDirectory(savePath):
	DirAccess.make_dir_absolute(savePath)
#
#
func LoadData():
	playerProgress = ResourceLoader.load(saveFilePath + saveFileName).duplicate(true)
		
func SaveData():
	ResourceSaver.save(playerProgress, saveFilePath + saveFileName)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#animation_player.play(doorState)
@onready var player = %player

func _on_area_2d_body_entered(_body):
	if(disabled == false):
		animation_player.play("openDoor")
		player.enterVisible(true)
		doorState = "opened"


func _physics_process(_delta):
	if(Input.is_action_just_pressed("attack") && doorState == 'opened' && disabled == false):
		playerProgress.setLvlComplete(NextLvl)
		SaveData()
		get_tree().change_scene_to_file("res://scenes/lvls/" + str(lvl) + ".tscn")


func _on_area_2d_body_exited(_body):
	if(disabled == false):
		animation_player.play("CloseDoor")
		player.enterVisible(false)
		doorState = 'closed'

