extends Camera2D

export var decay = 0.8
export var max_offset = Vector2(100,75)
export var max_roll = 0.1
export (NodePath) var target

var trauma = 0.0
var trauma_power = 2
onready var noise = OpenSimplexNoise.new()
var noise_y = 0

func ready():
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2

func _process(delta):
	if target:
		global_position = get_node(target).global_position
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
		
func shake():
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * rand_range(-0.1, 0.1)
	offset.x = max_offset.x * amount * rand_range(-0.1, 0.1)
	offset.y = max_offset.y * amount * rand_range(-0.1, 0.1)
	
func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)
