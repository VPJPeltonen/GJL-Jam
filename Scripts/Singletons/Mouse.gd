extends Node

var mouse_captured: bool = false
var enable_capture_on_click: bool = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func capture_mouse():
	mouse_captured = true
	enable_capture_on_click = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func free_mouse(enable_capture_on_click: bool = true):
	self.enable_capture_on_click = enable_capture_on_click
	mouse_captured = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event is InputEventMouseButton and enable_capture_on_click:
		capture_mouse()
	if mouse_captured and Input.is_action_just_pressed("ui_cancel"):
		free_mouse()
