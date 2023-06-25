extends CanvasLayer

var totalCoins = 0
var coins = 0
func _ready():
	var coinNodes = get_tree().get_nodes_in_group("Coin2D")
	var coinCount = coinNodes.size()
	print("Cantidad de instancias de Coin2D en la escena:", coinCount)
	
func _handleCoinCollected():
	print("Collected Coin")
	coins += 1
	$CoinCollect.text = String(coins)
	
	if coins == 3:
		get_tree().change_scene("res://Scenes/Mundo2.tscn")
