extends Control

var countdown = 5

func _ready():
	update_label()

func _on_Countdown_timeout():
	countdown -= 1
	update_label()
	
func update_label():
	$Countdown_lbl.text = "Starting in " + str(countdown)
	if countdown <= 0:
		hide()
		$Countdown.stop()
		get_tree().paused = false
