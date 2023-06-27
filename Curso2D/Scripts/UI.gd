extends CanvasLayer

# Variables para rastrear las monedas totales y las monedas recogidas.
var totalCoins: int = 0
var coins: int = 0

# Array para almacenar objetos encontrados con un script específico.
var objects_array: Array = []

# Referencia a la escena actual.
var current_scene: Node

# Lista de escenas de nivel.
var levelScenes = [
	"res://Scenes/Mundo1.tscn",
	"res://Scenes/Mundo2.tscn",
	"res://Scenes/Mundo3.tscn"
]

func _ready():
	# Obtener la escena actual.
	current_scene = get_tree().current_scene
	print(current_scene)

	# Tipo de script que se está buscando en la escena.
	var tipo_de_script: String = "Coin2D"

	# Llamar a la función para buscar objetos con el script especificado en la escena actual.
	buscar_objetos_con_script(current_scene, tipo_de_script)

	print("Cantidad de objetos encontrados:", objects_array.size())
	totalCoins = objects_array.size()

	# Imprimir los objetos encontrados.
	for obj in objects_array:
		print("Objeto encontrado:", obj)

# Función recursiva para buscar objetos con un script específico en la escena y sus hijos.
func buscar_objetos_con_script(scene_node: Node, script_type: String):
	if scene_node and scene_node.has_node(script_type):
		# Si el nodo tiene el script especificado, agregarlo al array de objetos encontrados.
		objects_array.append(scene_node)

	# Llamar a la función de forma recursiva para cada hijo del nodo actual.
	for child in scene_node.get_children():
		buscar_objetos_con_script(child, script_type)

func _handleCoinCollected():
	print("Collected Coin")
	coins += 1
	$CoinCollect.text = String(coins)

	if coins == totalCoins:
		# Si se han recogido todas las monedas, avanzar al siguiente nivel.
		GameManager.currentLevelIndex += 1
		change_to_next_level()

func change_to_next_level():
	if GameManager.currentLevelIndex >= levelScenes.size():
		# Si se alcanza el final de la lista de escenas, reiniciar al primer nivel.
		GameManager.currentLevelIndex = 0
	
	# Cambiar a la siguiente escena de nivel.
	get_tree().change_scene(levelScenes[GameManager.currentLevelIndex])
