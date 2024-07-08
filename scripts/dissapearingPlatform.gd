extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var shake_durration = $ShakeDurration
@onready var cpu_particles_2d = $CPUParticles2D
@onready var respawn_timer = $respawnTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func resetPlatform():
	animation_player.play("RESET")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_player_detection_area_body_entered(body):
	animation_player.play("shake")
	shake_durration.start()
	cpu_particles_2d.emitting = true
	
	
func _on_shake_durration_timeout():
	animation_player.play("dropPlatform")
	respawn_timer.start()


func _on_respawn_timer_timeout():
	animation_player.play("respawn")
	
