extends Node2D

class_name Pipe

signal pipe_passed

var gap: float = 300
var height: float = 100
var speed: float = 0.3

var width = 0

var top_pipe: Node2D
var bottom_pipe: Node2D

var move_progress: float = 0.0
var start_pos: Vector2
var end_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	top_pipe = $Top
	bottom_pipe = $Bottom
	width = $Top/CollisionShape2D.get_shape().get_rect().size.x
	
	start_pos = Vector2(get_viewport().get_visible_rect().size.x + width, height)
	end_pos = Vector2( - width, height)
	position = start_pos
	
	bottom_pipe.position.y = gap

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	move_progress += delta * speed
	position = start_pos.lerp(end_pos, move_progress)
	
	if (move_progress > 1):
		pipe_passed.emit()
		queue_free()

func _on_body_entered(body):
	if body is PlayerMovement:
		body.hit()
