extends Node


var is_game_started := false

var current_scene_ref: WeakRef

var level := 0
var levels = [
	"res://levels/level_1/level_1.tscn"
]


func _ready():
	var root = get_tree().get_root()
	var scene = root.get_child(root.get_child_count() - 1)
	current_scene_ref = weakref(scene)
	
	
func goto_scene(scene: PackedScene):
	call_deferred("_deferred_goto_scene", scene)
	
	
func start_new_game():
	is_game_started = true
	var lvl = load(levels[level])
	goto_scene(lvl)
	
	
func exit_game():
	get_tree().quit()
	
	
func _deferred_goto_scene(scene: PackedScene):
	var current_scene = current_scene_ref.get_ref()
	if current_scene:
		current_scene.free()
	
	var new_scene = scene.instantiate()
	current_scene_ref = weakref(new_scene)
	
	get_tree().get_root().add_child(new_scene)
	get_tree().set_current_scene(new_scene)
	
	
	
	
