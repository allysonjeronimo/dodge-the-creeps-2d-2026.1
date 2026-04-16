extends Area2D

signal hit 

@export var speed = 400
var direction = Vector2.ZERO
var screen_size
	
func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func start(pos):
	position = pos
	show()
	
func _process(delta):
	proccess_input(delta)
	update_animations()	
	
func proccess_input(delta):
	direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"): 
		direction.x = 1	
	if Input.is_action_pressed("move_left"):
		direction.x = -1	
	if Input.is_action_pressed("move_up"):
		direction.y = -1
	if Input.is_action_pressed("move_down"):
		direction.y = 1
		
	position += direction * speed * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
func update_animations():
	if direction != Vector2.ZERO:
		if direction.x != 0:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = direction.x < 0
			$AnimatedSprite2D.flip_v = false
		elif direction.y != 0:
			$AnimatedSprite2D.play("up")
			$AnimatedSprite2D.flip_v = direction.y > 0
	else:
		$AnimatedSprite2D.stop()
	
func _on_body_entered(body: Node2D):
	hit.emit()
