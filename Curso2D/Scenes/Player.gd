extends KinematicBody2D

const MOVE_SPEED = 25
const MAX_SPEED = 50

const JUMP_HEIGHT = -300
const JUMP_SIDE_FORCE = 300
const UP = Vector2(0, -1)
const GRAVITY = 15

onready var sprite = $SlimeBlue
onready var animationPlayer = $AnimationPlayer
var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY

	var moveInput = 0
	if Input.is_action_pressed("right"):
		moveInput += 1
		sprite.flip_h = true
		animationPlayer.play("walk")
	elif Input.is_action_pressed("left"):
		moveInput -= 1
		sprite.flip_h = false
		animationPlayer.play("walk")
	else:
		animationPlayer.play("idle")

	motion.x = lerp(motion.x, moveInput * MAX_SPEED, 0.2)

	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = JUMP_HEIGHT
			motion.x = moveInput * JUMP_SIDE_FORCE

	motion = move_and_slide(motion, UP)
