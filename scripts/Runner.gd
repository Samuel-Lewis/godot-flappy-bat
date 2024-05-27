extends Node2D

var score = 0
var playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menus.show_main_menu()
	
func _process(_delta):
	$Menus/GameUi/Title.text = str(score)

func new_game():
	playing = true
	score = 0
	$Menus.show_game_ui()
	$PipeManager.reset()
	$Player.reset()

func game_over():
	playing = false
	$Menus.show_game_over()
	$Menus/GameOver/Score.text = str(score)
	pass

func _on_player_player_dead():
	game_over()
	Audio.play_crash()
	
func _on_play_button_pressed():
	new_game()
	Audio.play_start()

func _on_pipe_manager_pipe_cleared():
	if playing:
		score += 1
		Audio.play_point()
