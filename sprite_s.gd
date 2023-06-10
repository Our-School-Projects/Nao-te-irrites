extends Area2D

var path_follow
var _speed =0
# Called when the node enters scene tree for the first time.
func _ready():
	path_follow= get_node("pathFollow2d")
	pass # Replace with function body.

func _physics_process(delta):
	path_follow.offset += _speed * delta
