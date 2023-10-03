extends CharacterBody2D


@onready var animated_sprite := $AnimatedSprite2D

const SPEED := 700

var target: CharacterBody2D
var target_fixed_start_pos := Vector2.ZERO


func _ready() -> void:
	animated_sprite.play("start")


func _physics_process(delta: float) -> void:	
	look_at(target_fixed_start_pos)
	move_and_slide()


func _on_animated_sprite__animation_finished():
	if animated_sprite.animation == "start":
		animated_sprite.play("move")
	if animated_sprite.animation == "explosion":
		self.queue_free()
	
	
func _on_explode_area_body_entered(body):
	velocity = Vector2.ZERO
	animated_sprite.play("explosion")
	
	
func throw(global_position: Vector2, direction: Vector2):
	self.global_position = global_position
	
	velocity = velocity.normalized()
	velocity = direction * SPEED
	
	
func set_target(body: CharacterBody2D):
	target = body
	target_fixed_start_pos = target.global_position
	
	
	
	
	
	
	
	
