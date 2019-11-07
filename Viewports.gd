extends PanelContainer

onready var Top = $HorizontalDiv/VerticalDivTop/TopLeft/Top
onready var Left = $HorizontalDiv/VerticalDivBottom/BottomLeft/Left
onready var Front = $HorizontalDiv/VerticalDivTop/TopRigth/Front
onready var Perspective = $HorizontalDiv/VerticalDivBottom/BottomRight/Perspective

func _ready():
	get_tree().connect("screen_resized",self,"_resize_viewport")
	get_tree().get_root().connect("size_changed",self, "_resize_viewport")
	var rectx = floor(rect_size.x/4)
	var recty = floor(rect_size.y/4)
	Top.get_parent().rect_size.x = rectx
	Top.get_parent().rect_size.y = recty
	Left.get_parent().rect_size.x = rectx
	Left.get_parent().rect_size.y = recty
	Front.get_parent().rect_size.x = rectx
	Front.get_parent().rect_size.y = recty
	Perspective.get_parent().rect_size.x = rectx
	Perspective.get_parent().rect_size.y = recty
	_resize_viewport(0)

func _resize_viewport(offset = 0):
	Top.size.x = Top.get_parent().rect_size.x
	Top.size.y = Top.get_parent().rect_size.y
	
	Left.size.x = Left.get_parent().rect_size.x
	Left.size.y = Left.get_parent().rect_size.y
	
	Front.size.x = Front.get_parent().rect_size.x
	Front.size.y = Front.get_parent().rect_size.y

	Perspective.size.x = Perspective.get_parent().rect_size.x
	Perspective.size.y = Perspective.get_parent().rect_size.y




func _resize_viewport_upper(offset):
	_resize_viewport(offset)
	$HorizontalDiv/VerticalDivBottom.split_offset = offset



func _resize_viewport_down(offset):
	_resize_viewport(offset)
	$HorizontalDiv/VerticalDivTop.split_offset = offset


func _on_BackGround_resized():
	_resize_viewport()
