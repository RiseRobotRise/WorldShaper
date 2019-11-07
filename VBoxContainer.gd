extends VBoxContainer
signal error_message(text)
onready var Layers : Tree = $ScrollContainer/Layers
const BSP_icon = preload("res://icons/icon_c_s_g_combiner.svg")
const Effects_icon = preload("res://icons/icon_particles.svg")
const Props_icon = preload("res://icons/icon_room.svg")
const Grid_icon = preload("res://icons/icon_grid_map.svg")
const World_icon = preload("res://icons/icon_world.png")

func _ready():
#	Layers.set_column_expand (2, false )
#	Layers.set_column_expand (0, false )
	Layers.set_column_expand (1, true )
	
	Layers.set_column_min_width(0,60)
	Layers.set_column_min_width(1,100)
	Layers.set_column_min_width(2, 20)
	var root = Layers.create_item()
	root.set_selectable(2, false)
	root.set_selectable(0, false)
	root.set_text (1, "World")
	root.set_icon(0, World_icon)
	
func create_layer(Name, icon):
	if get_level(Layers.get_selected()) < 3:
		var current = Layers.create_item(Layers.get_selected())
		current.set_cell_mode(2,TreeItem.CELL_MODE_CHECK)
		current.set_editable(2,true)
#	current.set_selectable(1, false)
#	current.set_selectable(0, false)
		current.set_checked(2,true)
		current.set_editable(1,true)
		current.set_text (1, Name)
		current.set_icon_max_width(0, 40)
		current.set_icon(0, icon)
	else:
		emit_signal("error_message", "Layer depth cannot be higher than 3")

func remove_all(current, i):
	if current != null:
		
		var items = current.get_children()
		var next = current.get_next()
		if next != null and i != 0:
			
#			print("Deleting relative:" + str(next.get_text(1)))
			remove_all(next, i+1)
		if items != null:
#			print("Deleting child: " + str(items.get_text(1)))
			remove_all(items, i+1)
		current.get_parent().remove_child(current)

func get_level(item):
	if item == null:
		return 0
	var result = 0
	if item.get_parent() != null:
		result += 1
		result += get_level(item.get_parent())
	else:
		result = 0
	return result

func _on_BSP_pressed():
	create_layer("BSP Layer", BSP_icon)

func _on_Grid_pressed():
	create_layer("Grid layer", Grid_icon)

func _on_Effects_pressed():
	create_layer("Effects_layer", Effects_icon)

func _on_Props_pressed():
	create_layer("Props layer", Props_icon)

func _on_Delete_pressed():
	var current = Layers.get_selected()
#	print("Deleting:" + str(current.get_text(1)))
	if current.get_parent()!=null:
		remove_all(current, 0)

