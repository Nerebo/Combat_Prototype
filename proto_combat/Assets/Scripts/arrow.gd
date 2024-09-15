extends Area2D

var speed: float = 0.4

@export_category("Objects")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_as_top_level(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += (Vector2.RIGHT * speed).rotated(rotation)



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.update_health(1)
		queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
