extends Node2D
@onready var animation_bird = $"animation bird"
@onready var cpu_particles_2d = $CPUParticles2D

func _on_area_2d_area_entered(_area):
	animation_bird.play("death")
	cpu_particles_2d.emitting = true
