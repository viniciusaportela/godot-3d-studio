extends Node3D

@export var speed = 10.0
@export var rotate_speed = 0.5
@export var zoom_speed = 1.0
var _initial_mouse_pos = Vector2()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE and event.is_pressed():
			_initial_mouse_pos = event.position
		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			_initial_mouse_pos = event.position
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			$Camera.translate(Vector3(0,0,1) * zoom_speed)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			$Camera.translate(Vector3(0,0,-1) * zoom_speed)

	if event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
			var delta = event.relative * speed / DisplayServer.screen_get_size()
			translate(Vector3(delta.x, 0, delta.y))
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			var delta = (event.position - _initial_mouse_pos) * rotate_speed / DisplayServer.screen_get_size()
			rotate_y(delta.x)
			$Camera.rotate_x(delta.y)
			_initial_mouse_pos = event.position
