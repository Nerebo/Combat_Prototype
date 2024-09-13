extends CharacterBody2D

@export_category("Variables")
@export var move_speed: float = 32.0
@export var _timer: Timer = null
@export_category("Objects")

@onready var animation = $Animacao
var is_attacking = false

var flip_h = false

func _physics_process(delta):
	move()
	
func _process(delta: float):
	var right = Input.is_action_pressed("move_right")
	var left = Input.is_action_pressed("move_left")
	var up = Input.is_action_pressed("move_up")
	var down = Input.is_action_pressed("move_down")
	var attack = Input.is_action_pressed("mouse")
	
	if(is_attacking == false):
		if right:
			if(flip_h == true):
				scale.x = -1
				flip_h = false
			animation.play("walk")
			return
		elif left:
			if(flip_h == false):
				scale.x = -1
				flip_h = true
			animation.play("walk")
			return
		elif up:
			animation.play("walk")
		elif down:
			animation.play("walk")
		elif attack:
			animation.play("attack")
			is_attacking = true
			$Attack_Timer.start()
		else:
			animation.play("idle")
			return
	else:
		set_physics_process(false)
		
func move():
	var direcao: Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	
	velocity = direcao.normalized() * move_speed
	move_and_slide()


func _on_attack_timer_timeout() -> void:
	is_attacking = false
	set_physics_process(true)

	
