extends CanvasLayer

var totalCoins: int = 0
var coins: int = 0
var objects_array: Array = []
var current_scene: Node

func _ready():
	current_scene = get_tree().current_scene
	print(current_scene)
	var tipo_de_script: String = "Coin2D"
	buscar_objetos_con_script(current_scene, tipo_de_script)

	# Imprime la cantidad de objetos encontrados
	print("Cantidad de objetos encontrados:", objects_array.size())
	totalCoins = objects_array.size()
	

	# Realiza acciones con los objetos encontrados
	for obj in objects_array:
		# Realiza acciones con cada objeto encontrado
		print("Objeto encontrado:", obj)

	# Resto del código...

# Busca objetos con un tipo de script específico
func buscar_objetos_con_script(scene_node: Node, script_type: String):
	if scene_node and scene_node.has_node(script_type):
		# El nodo tiene un hijo con el script deseado, añádelo al array
		objects_array.append(scene_node)

	# Recorre los hijos del nodo actual
	for child in scene_node.get_children():
		buscar_objetos_con_script(child, script_type)

func _handleCoinCollected():
	print("Collected Coin")
	coins += 1
	$CoinCollect.text = String(coins)

	if coins == totalCoins:
		get_tree().change_scene("res://Scenes/Mundo2.tscn")
