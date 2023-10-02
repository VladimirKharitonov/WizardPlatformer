extends CharacterBody2D


enum {
	ATTACK,
	WANDERING,
	IDLE
}

@onready var animated_sprite := $AnimatedSprite2D
var player: CharacterBody2D

const IDLE_SPEED := 120
const RUN_SPEED  := 200
var   state      := IDLE
var   axis       := [Vector2.LEFT, Vector2.RIGHT]

const GRAVITY := 9.8 * 80


func _ready():
	randomize()


func _physics_process(delta: float):
	if state == IDLE:
		if $TimerIdle.is_stopped():
			velocity = Vector2.ZERO
			$TimerIdle.start(randi_range(0, 4))
	elif state == WANDERING:
		if $TimerWandering.is_stopped():
			$TimerWandering.start(randi_range(1, 3))
			velocity = axis.pick_random() * IDLE_SPEED
	elif state == ATTACK:
		$TimerIdle.stop()
		$TimerWandering.stop()
		var t = (player.global_position - self.global_position).normalized()
		velocity = (Vector2.LEFT if Vector2.RIGHT.dot(t) < Vector2.LEFT.dot(t) else Vector2.RIGHT) * RUN_SPEED
	check_down(velocity)
	
	velocity.y = GRAVITY
	animated_sprite.play("wandering")
	
	move_and_slide()
	
	
func check_down(veloc: Vector2):
	var speed = IDLE_SPEED if state == WANDERING else RUN_SPEED
	veloc = veloc.normalized()
	if veloc == Vector2.LEFT and (!$RayCastLDown.is_colliding() or $RayCastL.is_colliding()):
		velocity = Vector2.RIGHT * speed
	if veloc == Vector2.RIGHT and (!$RayCastRDown.is_colliding() or $RayCastR.is_colliding()):
		velocity = Vector2.LEFT * speed


func _on_timer_idle_timeout():
	state = WANDERING


func _on_timer_wandering_timeout():
	state = IDLE


func _on_detected_area_body_entered(body):
	if body.is_in_group("players") and body is CharacterBody2D:
		player = body
	state = ATTACK


func _on_exit_area_body_exited(body):
	if body == player:
		player = null
		state = IDLE
