extends CollisionShape2D

@onready var slime_node = $"../.."

func takeDamage():
	slime_node.queue_free()
