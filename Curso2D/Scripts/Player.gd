extends KinematicBody2D

const MOVE_SPEED = 25  # Velocidad de movimiento del personaje.
const MAX_SPEED = 50   # Velocidad máxima del personaje.

const JUMP_HEIGHT = -300        # Altura del salto del personaje.
const JUMP_SIDE_FORCE = 300     # Fuerza lateral aplicada durante el salto.
const UP = Vector2(0, -1)       # Vector de dirección hacia arriba.
const GRAVITY = 15              # Gravedad que afecta al personaje.

onready var sprite = $SlimeBlue                # Referencia al nodo Sprite del personaje.
onready var animationPlayer = $AnimationPlayer  # Referencia al nodo AnimationPlayer para reproducir animaciones.
var motion = Vector2()                          # Vector de movimiento del personaje.

func _physics_process(delta):
	motion.y += GRAVITY  # Aplica la gravedad al movimiento vertical del personaje.

	var moveInput = 0
	if Input.is_action_pressed("right"):
		moveInput += 1
		sprite.flip_h = true
		animationPlayer.play("walk")  # Reproduce la animación de caminar hacia la derecha.
	elif Input.is_action_pressed("left"):
		moveInput -= 1
		sprite.flip_h = false
		animationPlayer.play("walk")  # Reproduce la animación de caminar hacia la izquierda.
	else:
		animationPlayer.play("idle")  # Reproduce la animación de estar en reposo.

	motion.x = lerp(motion.x, moveInput * MAX_SPEED, 0.2)  # Interpola la velocidad horizontal para suavizar los cambios bruscos.

	if is_on_floor():  # Verifica si el personaje está en el suelo.
		if Input.is_action_just_pressed("jump"):
			motion.y = JUMP_HEIGHT
			motion.x = moveInput * JUMP_SIDE_FORCE  # Aplica una fuerza lateral al salto según la dirección del movimiento.

	motion = move_and_slide(motion, UP)  # Mueve y desliza al personaje según la gravedad y la dirección del movimiento.

func add_coin():
	var canvasLayer = get_tree().get_root().find_node("CanvasLayer", true, false)
	canvasLayer._handleCoinCollected()  # Llama a la función _handleCoinCollected() en el nodo CanvasLayer cuando se recoge una moneda.


func _on_Spikes_body_entered(body):
	if body.get_name() == "Player":
		get_tree().reload_current_scene()
