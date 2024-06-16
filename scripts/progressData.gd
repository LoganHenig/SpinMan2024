extends Resource
class_name ProgressData

@export var lvl1_1 = true
@export var lvl1_2 = false
@export var lvl1_3 = false
@export var lvl1_4 = false
@export var lvl1_boss = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func setLvlComplete(lvl):
	if(lvl == "lvl1_1"):
		lvl1_1 = true
	elif( lvl == "lvl1_2"):
		lvl1_2 = true
	elif( lvl == "lvl1_3"):
		lvl1_3 = true
	elif( lvl == "lvl1_4"):
		lvl1_4 = true
	elif( lvl == "lvl1_boss"):
		lvl1_boss = true
		
func checkLvl(lvl):
	if(lvl == "lvl1_1"):
		return lvl1_1
	elif( lvl == "lvl1_2"):
		return lvl1_2
	elif(lvl == "lvl1_3"):
		return lvl1_3
	elif( lvl == "lvl1_4"):
		return lvl1_4
	elif( lvl == "lvl1_boss"):
		return lvl1_boss
	else:
		return true
