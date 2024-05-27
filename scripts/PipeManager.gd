extends Node

const PIPE_SCENE = preload ("res://scenes/pipe_large.tscn")
const MAX_WAIT = 2.5
const MIN_WAIT = 1.0
const SPEED_UP = 0.2

const HEIGHT_PADDING = 25
const MAX_HEIGHT_CHANGE = 100

const MAX_GAP = 400
const MIN_GAP = 100
const MAX_GAP_CHANGE = 50

signal pipe_cleared

var random = RandomNumberGenerator.new()

var last_gap = 300
var last_height = 100

var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $Timer
	random.randomize()
	reset()

func reset():
	timer.wait_time = MAX_WAIT
	timer.stop()
	timer.start()
	clear_pipes()
	spawn_pipe()
	
func clear_pipes():
	last_gap = 300
	last_height = 100
	for n in $Pipes.get_children():
		$Pipes.remove_child(n)
		n.queue_free()
	pass
	
func stop():
	timer.stop()
	
func spawn_pipe():
	var pipe = PIPE_SCENE.instantiate()
	var new_gap = clamp(last_gap + random.randi_range( - MAX_GAP_CHANGE, MAX_GAP_CHANGE), MIN_GAP, MAX_GAP)
	var new_height = clamp(last_height + random.randi_range( - MAX_HEIGHT_CHANGE, MAX_HEIGHT_CHANGE), HEIGHT_PADDING, get_viewport().get_visible_rect().size.y - HEIGHT_PADDING)
	
	pipe.connect("pipe_passed", self.pipe_passed)
	
	if pipe is Pipe:
		pipe.gap = new_gap
		pipe.height = new_height
	
	last_gap = new_gap
	last_height = new_height
	
	$Pipes.add_child(pipe)
	
	# Reduce the time
	timer.wait_time = clamp(timer.wait_time, MIN_WAIT, MAX_WAIT)

func _on_timer_timeout():
	spawn_pipe()

func pipe_passed():
	pipe_cleared.emit()
