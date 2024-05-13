extends Node2D

# Reference to the scene containing the building templates
var building_template_scene = preload("res://scene/Buildings.tscn")

# Function to create a new building of a specified type
func create_building(building_type: String, position: Vector2) -> Building:
	# Load the building template scene
	var building_instance = building_template_scene.instance()
	
	# Add the building instance to the scene
	add_child(building_instance)
	
	# Set the position of the building
	building_instance.global_position = position
	
	# Set the building type (you may have a script property in your building scene to store the type)
	building_instance.set_building_type(building_type)
	
	# Return the building instance in case you need to do further processing
	return building_instance
