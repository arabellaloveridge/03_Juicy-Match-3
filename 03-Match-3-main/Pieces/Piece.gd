extends Node2D

export (String) var color
var is_matched
var is_counted
var selected = false
var target_position = Vector2.ZERO
var default_modulate = Color(1,1,1,1)
var highlight = Color(1,0.8,0,1)

var fall_speed = 0.75
var move_speed = 1.0

var rotate_range = deg2rad(10)
var rotate_speed = 0.75
var rotate_start

onready var Coin = load("res://Coin/Coin.tscn")

var dying = false
var dying_progress = 0

var Effects = null

func _ready():
	randomize()
	$Sprite.material = $Sprite.material.duplicate()
	rotate_start = rotation 	

func _process(delta):
	rotation += rotate_speed * delta
	var rotate_diff = rotation - rotate_start 
	if abs(rotate_diff) > rotate_range:
		rotation = rotate_start + rotate_range * sign(rotate_diff)
		rotate_speed *= -1

func _physics_process(_delta):
	if dying and not $Tween.is_active() and dying_progress >= 1:
		queue_free()
	if dying: 
		dying_progress += 0.01
		$Sprite.material.set_shader_param("progress", dying_progress)
	if not dying and target_position != Vector2.ZERO and not $Moving.is_active() and target_position != position:
		$Moving.interpolate_property(self, "position", position, target_position, move_speed, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
		$Moving.start()
	if selected:
		$Selected.emitting = true
		$Select.show()
		z_index = 10
	else:
		$Selected.emitting = false
		$Select.hide()
		z_index = 1

func move_piece(change):
	target_position = position + change
	
func move_piece_to(change):
	target_position = change 
	
func die():	
	dying = true
	var coin = Coin.instance()
	coin.position = position
	get_node("/root/Game/Effects").add_child(coin)
	var target_color = $Sprite.modulate
	target_color.s = 1
	target_color.h = randf()
	target_color.a = 0
	var fall_duration = randf()*fall_speed + 1
	var rotate_amount = (randi() % 1440) - 720
	
	var target_pos = position
	target_pos.y = 1100
	$Tween.interpolate_property(self, "position", position, target_pos, fall_duration, Tween.TRANS_CUBIC, Tween.EASE_IN)
	$Tween.start()
	$Tween.interpolate_property($Sprite, "modulate", $Sprite.modulate, target_color, fall_duration-0.25, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.start()
	$Tween.interpolate_property(self, "rotation_degrees", rotation_degrees, rotate_amount, fall_duration-0.25, Tween.TRANS_QUINT, Tween.EASE_IN)
	$Tween.start()
	
	
