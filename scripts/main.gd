extends Node2D

var score
@export var enemy_scene: PackedScene
@export var bomb_scene: PackedScene

func _ready():
	pass
	
func start_game():
	score = 0
	$HUD.update_score(score)
	get_tree().call_group("enemy", "queue_free")
	$ScoreTimer.start()
	$EnemyTimer.start()
	$Player.start($StartPosition.position)
	$BackMusic.play()
	
func game_over():
	$Player.hide()
	$EnemyTimer.stop()
	$ScoreTimer.stop()
	$HUD.show_game_over()
	$BackMusic.stop()
	$DeathSound.play()
	
func _on_enemy_timer_timeout() -> void:
	var new_enemy = enemy_scene.instantiate()
	# definir posição
	var path_follow_2d = $Path2D/PathFollow2D
	path_follow_2d.progress_ratio = randf()
	new_enemy.position = path_follow_2d.position
	# definir rotação
	var enemy_rotation = path_follow_2d.rotation + PI/2
	enemy_rotation += randf_range(-PI/4, PI/4)
	new_enemy.rotation = enemy_rotation
	# movimentação

	var random_x = randf_range(100.0, 250.0);
	var velocity = Vector2(random_x, 0)
	new_enemy.linear_velocity = velocity.rotated(new_enemy.rotation)
	
	# etc
	add_child(new_enemy)

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)
	if(score % 3 == 0):
		spawn_bomb()
	
func spawn_bomb():
	print("Spawn Bomb!")

func _on_player_hit() -> void:
	game_over()

func _on_hud_start() -> void:
	start_game()
