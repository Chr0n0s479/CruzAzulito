extends CharacterBody2D

signal hit

@export var speed = 700
var screen_size 

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed('move_right'):
		velocity.x += 1
	if Input.is_action_pressed('move_left'):
		velocity.x -= 1
	if Input.is_action_pressed('move_down'):
		velocity.y += 1
	if Input.is_action_pressed('move_up'):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	if velocity.x != 0:
		# Selecciona la animación correspondiente según la dirección del movimiento
		if velocity.x < 0:
			$AnimatedSprite2D.animation = 'walk_2'  # Animación para caminar hacia la izquierda
			$AnimatedSprite2D.flip_h = true  # Activar flip horizontal para izquierda
		else:
			$AnimatedSprite2D.animation = 'walk'  # Animación para caminar hacia la derecha
			$AnimatedSprite2D.flip_h = false  # Desactivar flip horizontal para derecha

		$AnimatedSprite2D.flip_v = false  # No flip vertical para caminar




func _on_body_entered(body):
	
	hide()
	hit.emit()
	
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	
	$CollisionShape2D.disabled = false
