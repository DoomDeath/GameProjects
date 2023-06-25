extends Area2D

signal coinCollected
func _on_Coin2D_body_entered(body):
	if body.get_name() == "Player":
		body.add_coin()
#		emit_signal("coinCollected")
		queue_free()
	
