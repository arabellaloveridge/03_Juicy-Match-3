extends Control

func _ready():
	update_label()
	
func level_over():
	show()
	
func update_label():
	$Label.text = "You scored " + str(Global.score) + " points"

func _on_Button_pressed():
	get_tree().change_scene("res://Game2.tscn")
