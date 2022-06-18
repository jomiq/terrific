extends Node3D

@export var speed := 0.1:
	set(value):
		speed = value


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(0.3 * delta)
	
