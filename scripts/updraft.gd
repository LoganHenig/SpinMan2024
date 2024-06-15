extends Area2D

@onready var player = $"../player"

func _on_body_entered(_body):
	player.upDraft(true)
	print('enter')


func _on_body_exited(_body):
	player.upDraft(false)
	print('exit')
