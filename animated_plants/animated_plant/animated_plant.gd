extends StaticBody2D


@onready var animated_sprite := $AnimatedSprite2D


func _ready() -> void:
	animated_sprite.play("swaying")
