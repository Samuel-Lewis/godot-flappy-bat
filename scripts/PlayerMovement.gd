extends CharacterBody2D

class_name PlayerMovement

const JUMP_VELOCITY: float = -400.0
const MAX_VELOCITY: int = 800

signal player_dead

var animated_sprite: AnimatedSprite2D
var collision: CollisionShape2D
var alive = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animated_sprite = $AnimatedSprite2D
	hide()

func reset():
	# log death and reset
	show()
	velocity = Vector2(0, 0)
	position.y = -50
	animated_sprite.stop()
	alive = true
	animated_sprite.flip_v = false

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta
	
	# Handle jump.
	if alive and Input.is_action_just_pressed("flap"):
		velocity.y = JUMP_VELOCITY
		animated_sprite.stop()
		animated_sprite.play("default")

	velocity.y = clamp(velocity.y, -MAX_VELOCITY, MAX_VELOCITY)

	move_and_slide()

func _process(_delta):
	# check for out of bounds
	if (!alive):
		return
	
	if position.y > get_viewport().get_visible_rect().size.y + 20 or position.x < - 100:
		hit()

func hit():
	animated_sprite.flip_v = true
	alive = false
	player_dead.emit()
