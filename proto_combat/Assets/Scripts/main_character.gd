extends CharacterBody2D

@export_category("Variables")
@export var move_speed: float = 32.0
@export_category("Objects")

@onready var animation = $Animacao

func _physics_process(delta):
	move()
	
func _process(delta: float):
	var right = Input.is_action_pressed("move_right")
	var left = Input.is_action_pressed("move_left")
	if right:
		animation.play("walk")
		return
	elif left:
		animation.play("walk_l")
		return
	else:
		animation.play("idle")
		return
		
func move():
	var direcao: Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	
	if direcao != Vector2.ZERO:
		print(direcao)
	velocity = direcao.normalized() * move_speed
	move_and_slide()
