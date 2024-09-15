extends CharacterBody2D

@export_category("Variables")
@export var move_speed: float = 32.0
@export var _timer: Timer = null
@export_category("Objects")

@onready var animation = $Animacao
var is_attacking = false
var is_dead = false
var bow_cooldown = true
var arrow = preload("res://Assets/Scripts/arrow.tscn")

func _physics_process(delta):
	move()

func _process(delta: float):
	var right = Input.is_action_pressed("move_right")
	var left = Input.is_action_pressed("move_left")
	var up = Input.is_action_pressed("move_up")
	var down = Input.is_action_pressed("move_down")
	var attack = Input.is_action_pressed("mouse")
	
	var mouse = get_global_mouse_position()
	$Marker2D.look_at(mouse)
	
	if(is_dead == false):
		if(is_attacking == false):
			if right:
				$Soldier.flip_h = false
				animation.play("walk")
				return
			elif left:
				$Soldier.flip_h = true
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
	else:
		set_physics_process(false)
	
func move():
	var direcao: Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	
	velocity = direcao.normalized() * move_speed
	move_and_slide()

func _die():
	$Death_Timer.start()
	animation.play("death")
	set_physics_process(false)


func _on_attack_timer_timeout() -> void:
	var arrow_instance = arrow.instantiate()
	arrow_instance.rotation = $Marker2D.rotation
	arrow_instance.global_position = $Marker2D.global_position
	add_child(arrow_instance)
	is_attacking = false
	set_physics_process(true)


func _on_death_timer_timeout() -> void:
	pass
