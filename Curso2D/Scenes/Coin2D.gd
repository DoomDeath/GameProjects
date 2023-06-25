extends Area2D

# Variable global para el contador de monedas
var coinCount = 0

func _on_Coin2D_body_entered(body):
	queue_free()
	coinCount += 1
	print("Monedas recogidas: ", coinCount)
	
