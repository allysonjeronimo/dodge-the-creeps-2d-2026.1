extends CanvasLayer

signal start

func update_score(score):
	$ScoreLabel.text = "SCORE: " + str(score)
	
func show_message(message):
	$MessageLabel.text = message
	$MessageLabel.show()
	
func show_game_over():
	show_message("Game Over")
	await get_tree().create_timer(2.0).timeout
	show_message("Dodge The Creeps!")
	$StartButton.show()
		
func _on_start_button_pressed() -> void:
	start.emit()
	$StartButton.hide()
	$MessageLabel.hide()
