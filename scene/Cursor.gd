extends Node2D

var hand = load("res://assets/cursors/HandPointer.png")

func change_cursor(cursor: String):
	if cursor == "hand":
		Input.set_custom_mouse_cursor(hand)
	else:
		Input.set_default_cursor_shape()
