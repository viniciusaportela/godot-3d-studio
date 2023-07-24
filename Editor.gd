extends Node3D

var is_moving = false
var is_rotating = false

var last_pos
var last_mouse_pos

var last_basis
var last_mouse_basis_pos

func _process(delta):
	if (is_moving):
		var current_mouse_pos = get_viewport().get_mouse_position()
		
		var x_diff = -(current_mouse_pos.x - last_mouse_pos.x) * delta * 0.5
		var z_diff = -(current_mouse_pos.y - last_mouse_pos.y) * delta * 0.5
		print(x_diff, z_diff)
		
		$CameraRig.translate(Vector3(x_diff, 0, 0))
		$CameraRig.translate_object_local(Vector3(0, 0, z_diff))
		
		last_pos = $CameraRig.position
		last_mouse_pos = current_mouse_pos
	
	if (is_rotating):
		var current_mouse_pos = get_viewport().get_mouse_position()
		
		var x_diff = -(current_mouse_pos.x - last_mouse_basis_pos.x) * delta * 0.5
		var z_diff = -(current_mouse_pos.y - last_mouse_basis_pos.y) * delta * 0.5
		
#		$CameraRig.rotate_object_local(Vector3(0, 1, 0), x_diff)
#		$CameraRig.rotate_object_local(Vector3(1, 0, 0), z_diff)
		$CameraRig.rotation.y += x_diff
		$CameraRig/Inner.rotation.x += z_diff
		
#		$CameraRig.rotate_y(x_diff)
#		$CameraRig.rotate_x(z_diff)
		
		last_basis = $CameraRig.position
		last_mouse_basis_pos = current_mouse_pos

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				is_moving = true
				last_pos = $CameraRig.position
				last_mouse_pos = get_viewport().get_mouse_position()
			else:
				is_moving = false
		
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.is_pressed():
				is_rotating = true
				last_basis = $CameraRig.transform.basis
				last_mouse_basis_pos = get_viewport().get_mouse_position()
			else:
				is_rotating = false
