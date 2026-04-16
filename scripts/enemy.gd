extends RigidBody2D

func _ready():
	var enemy_animations = $AnimatedSprite2D.sprite_frames.get_animation_names()
	var random_index = randi() % enemy_animations.size() 
	$AnimatedSprite2D.play(enemy_animations[random_index])
	
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("Destruindo inimigo!")
	queue_free()
