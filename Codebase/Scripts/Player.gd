extends KinematicBody2D

const DIR_UP = Vector2(0, -1)

const GRAVITY = 20
const MAXFALLSPEED = 1000
const RL_ACCEL = 10
const MAX_RL_SPEED = 300
const MAX_JUMP_HEIGHT = -500

var motion = Vector2()


func _physics_process(_delta):
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	if Input.is_action_pressed("ui_right"):
		motion.x += RL_ACCEL
		$Sprite.flip_h = false
		$Sprite.play('run')
	elif Input.is_action_pressed("ui_left"):
		motion.x -= RL_ACCEL
		$Sprite.flip_h = true
		$Sprite.play('run')
	elif Input.is_action_pressed("ui_down"):
		$Sprite.play('crouch')
		motion.x = 0
	else:
		$Sprite.play('idle')
		motion.x = 0
		
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = MAX_JUMP_HEIGHT
	else:
		$Sprite.play('jump')
			
	
	motion.x = clamp(motion.x, -MAX_RL_SPEED, MAX_RL_SPEED)
	motion = move_and_slide(motion, DIR_UP)
