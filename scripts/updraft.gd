extends Area2D

@onready var player = $"../player"

func _on_body_entered(body):
	player.upDraft(true)
	print('enter')


func _on_body_exited(body):
	player.upDraft(false)
	print('exit')
