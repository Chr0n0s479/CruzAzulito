extends StaticBody2D

signal hit
# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start():
	#position = pos
	show()


func _on_body_entered(body: Node) -> void:
	print(body.get_class())
	hide()
	hit.emit()
	
	$CollisionShape2D.set_deferred("disabled", true)
	pass # Replace with function body.
