extends CharacterBody2D

var player_ref = null
var is_dead: bool = false
var health: int = 2
@onready var animation = $AnimationPlayer

@export_category("Objects")
@export var _texture: Sprite2D = null
@export var _animation: AnimationPlayer = null
@onready var hp_bar = $HP

func _on_ready():
	hp_bar.value = health
	
func _on_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Personagem"):
		player_ref = body

func _physics_process(delta: float) -> void:
	if is_dead:
		return
	if player_ref != null:
		if player_ref.is_dead:
			velocity = Vector2.ZERO
			move_and_slide()
			return
			
		var direction: Vector2 = global_position.direction_to(player_ref.global_position)
		var distance: float = global_position.distance_to(player_ref.global_position)
		velocity = direction * 40
		
		if velocity.x > 0:
			$Sprite2D.flip_h = false
		elif velocity.x < 0:
			$Sprite2D.flip_h = true
		
		if distance < 27:
			player_ref.is_dead = true
			player_ref._die()
				
	if player_ref == null:
		animation.play("idle")
	elif player_ref != null:
		animation.play("walk")
	move_and_slide()

func update_health(damage):
	print("health: ", health)
	print("damage: ", damage)
	health = health - damage
	hp_bar.value = health
	if(health == 0):
		is_dead = true
		animation.play("death")


func _on_animation_player_animation_finished(anim_name: String) -> void:
	queue_free()
