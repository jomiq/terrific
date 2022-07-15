extends Label

@export var target: Node
@export var parameter: String

var props
var idx

# Called when the node enters the scene tree for the first time.
func _ready():
	props = target.get_property_list()
	idx = props.find(parameter)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "%f" % props[idx]
	pass
