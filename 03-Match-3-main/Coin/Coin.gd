extends Node2D

onready var Coin_Sound = get_node("/root/Game/Coin_Sound")
#onready var Break_Sound = get_node("/root/Game/Break_Sound")

func _ready():
	z_index = 1000
	scale = Vector2.ZERO
	$Tween.interpolate_property(self, "scale", Vector2.ZERO, Vector2(.25,.25), 0.5, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()
	$Tween.interpolate_property(self, "position", position, Vector2(85,15), 1.5, Tween.TRANS_EXPO, Tween.EASE_OUT, 0.25)
	$Tween.start()
	$Tween.interpolate_property(self, "scale", Vector2(.25,.25), Vector2.ZERO, 1.5, Tween.TRANS_BOUNCE, Tween.EASE_OUT, 0.6)
	$Tween.start()
	Coin_Sound.called()
	#Break_Sound.called()
	
	
func _physics_process(_delta):
	if not $Tween.is_active():
		queue_free()
