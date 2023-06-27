extends Control



func _ready():
	$VBoxContainer/StarGame.grab_focus()



func _on_StarGame_pressed():
	get_tree().change_scene("res://Scenes/Mundo.tscn") # Replace with function body.


func _on_QuitButton_pressed():
	get_tree().quit()
