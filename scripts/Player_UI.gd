extends Control

@onready var resource_list = $CanvasLayer/Main/ActionBarContainer/ResourceList
var PLAYER_REF: CharacterBody2D

func set_player_ref(player: CharacterBody2D):
	PLAYER_REF = player

# Modify the text property of the round item in the ItemList
func set_new_round(new_round: int):
	print(new_round)
	resource_list.set_item_text(0, str(new_round))

# Modify the text property of the gold item in the ItemList
func set_new_gold(gained_gold: int):
	var gold_index = 1
	var current_gold_text = resource_list.get_item_text(gold_index)
	var new_gold = int(current_gold_text) + gained_gold
	resource_list.set_item_text(gold_index, str(new_gold))

# Modify the text property of the lumber item in the ItemList
func set_new_lumber(gained_lumber: int):
	var lumber_index = 2
	var current_lumber_text = resource_list.get_item_text(lumber_index)
	var new_lumber = int(current_lumber_text) + gained_lumber
	resource_list.set_item_text(lumber_index, str(new_lumber))


func _on_button_button_up_A1():
	print("Enter placement mode")
	PLAYER_REF.enter_build_mode('wall')
	#PLAYER_REF.enter_build_mode()

func _on_button_button_up_A2():
	pass # Replace with function body.



