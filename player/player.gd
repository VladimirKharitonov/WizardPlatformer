extends CharacterBody2D


@onready var animated_sprite   := $AnimatedSprite2D
@onready var collision_polygon := $CollisionPolygon2D

const DASH          :=  2.0
const SPEED         :=  400
const GRAVITY       :=  9.8 * 80
const JUMP_STRENGTH := -700.0

var jump_velocity := 0.0
var jump          := 1

func _ready():
	animated_sprite.play("idle")


func _physics_process(delta: float):
	
	normal_move_test()
	dash_move_test()
	jump_move_test(delta)
	
	move_and_slide()
	
	
	
func normal_move_test() -> void:
	velocity.y = GRAVITY
	
	if Input.is_action_pressed("left") and animated_sprite.animation != "dash":
		animated_sprite.flip_h = true
		animated_sprite.play("walk")

		velocity.x = -SPEED
	elif Input.is_action_pressed("right") and animated_sprite.animation != "dash":
		animated_sprite.flip_h = false
		animated_sprite.play("walk")

		velocity.x = SPEED
	elif animated_sprite.animation != "dash":
		velocity.x = 0
		animated_sprite.play("idle")
		
	up_direction = Vector2.UP
		
		
func dash_move_test() -> void:
	if Input.is_action_just_pressed("left_dash"):
		animated_sprite.flip_h = true
		animated_sprite.play("dash")
		
		velocity.x = -SPEED * DASH
	elif Input.is_action_just_pressed("right_dash"):
		animated_sprite.flip_h = false
		animated_sprite.play("dash")
		
		velocity.x = SPEED * DASH
	
	
func jump_move_test(delta: float) -> void:
	if animated_sprite.animation != "dash":
		if Input.is_action_just_pressed("jump") and jump < 2:
			jump_velocity = JUMP_STRENGTH
			jump += 1
		
		if jump_velocity <= 0:
			jump_velocity += GRAVITY * delta * 2
			velocity.y = jump_velocity
		
		if is_on_floor():
			jump = 1
		
		if velocity.y <= 0:
			animated_sprite.play("jump")
		
		if $RayCastUp.is_colliding():
			jump_velocity = 0
			velocity.y = GRAVITY


func _is_animation_finished():
	if animated_sprite.animation == "dash":
		velocity.x = 0
		if is_on_floor():
			animated_sprite.play("idle")
		else:
			animated_sprite.play("jump")
