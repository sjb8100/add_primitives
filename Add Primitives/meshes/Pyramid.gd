extends "builder/MeshBuilder.gd"

var width = 2.0
var length = 2.0
var height = 1.0

static func get_name():
	return "Pyramid"
	
static func get_container():
	return "Extra Objects"
	
func set_parameter(name, value):
	if name == 'Width':
		width = value
		
	elif name == 'Length':
		length = value
		
	elif name == 'Height':
		height = value
		
func create(smooth = false, invert = false):
	var offset = Vector3(width/2, height/2, length/2)
	
	var plane = build_plane_verts(Vector3(width,0,0), Vector3(0,0,length), -offset)
	
	var uv = [Vector2(1, 1), Vector2(0, 1), Vector2(0, 0), Vector2(1, 0)]
	
	var ch = Vector3(0, height, 0)
	
	begin(VS.PRIMITIVE_TRIANGLES)
	
	add_smooth_group(smooth)
	
	add_quad(plane, uv, invert)
	
	uv = [uv[0], uv[1], Vector2(0.5, 0.5)]
	
	if invert:
		plane.invert()
		
	add_tri([ch, plane[1], plane[0]], uv, invert)
	add_tri([ch, plane[2], plane[1]], uv, invert)
	add_tri([ch, plane[3], plane[2]], uv, invert)
	add_tri([ch, plane[0], plane[3]], uv, invert)
	
	var mesh = commit()
	
	return mesh
	
func mesh_parameters(tree):
	add_tree_range(tree, 'Width', width)
	add_tree_range(tree, 'Length', length)
	add_tree_range(tree, 'Height', height)
	

