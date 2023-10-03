extends Node2D


@onready var water_balls := $WaterBalls
@onready var player      := $Player


func _physics_process(delta: float):
	if Input.is_action_just_released("left_click"):
		throw_water_ball()


func throw_water_ball():
	var water_ball = preload("res://player/water_ball/water_ball.tscn").instantiate()
	water_balls.add_child(water_ball)

	var direction = (get_global_mouse_position() - player.global_position).normalized()
	water_ball.set_target(player)
	water_ball.throw(player.global_position, direction)
