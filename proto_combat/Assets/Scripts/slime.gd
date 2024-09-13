extends CharacterBody2D

var player_ref = null
@onready var animation = $AnimationPlayer

@export_category("Objects")
@export var _texture: Sprite2D = null
@export var _animation: AnimationPlayer = null

func _on_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Personagem"):
		player_ref = body


func _on_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("Personagem"):
		player_ref = null
		
func _physics_process(delta: float) -> void:
	if player_ref != null:
		var direction: Vector2 = global_position.direction_to(player_ref.global_position)
		velocity = direction * 40
	
	if player_ref == null:
		animation.play("idle")
	elif player_ref != null:
		if velocity.x > 0:
			_texture.flip_h = false
		elif velocity.x < 0:
			_texture.flip_h = true
		animation.play("walk")
	move_and_slide()
