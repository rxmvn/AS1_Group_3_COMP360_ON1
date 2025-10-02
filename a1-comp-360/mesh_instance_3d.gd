# script generates 3D terrain using noise function/FastNoiseLite

# allows script to run in editor so terrain updates right away
@tool
extends MeshInstance3D

# total size of terrain in x/z directions
const TERRAIN_SIZE := 256.0    

# number of quads along the x axis
@export var rows: int = 64:    
	set(value):
		rows = max(2, value)  # ensures atleast 2 rows
		_build_terrain()    # rebuild terrain whenever value changes

# number of quads along z axis
@export var cols: int = 64:    
	set(value):
		cols = max(2, value)   # ensures atleast 2 columns
		_build_terrain()

# max height of hills 
@export var hill_height: float = 64.0:
	set(value):
		hill_height = value    # update hill height
		_build_terrain()       # rebuild terrain when changed

# the noise generator used to create terrain variation
@export var noise: FastNoiseLite:
	set(value):
		noise = value
		if noise:
			noise.changed.connect(_build_terrain)
		_build_terrain()
		# rebuild terrain if noise parameters change

# internal storage for the heightmap texture
var heightmap: ImageTexture

# main methods

# returns terrain height at a given world position (x, z)
func _get_height(x: float, z: float) -> float:
	if noise == null:
		return 0.0    # this will return flat terrain if no noise set
	return noise.get_noise_2d(x, z) * hill_height     # scale noise value by hill height

# calculates surface normal at given point for lighting
func _get_normal(x: float, z: float, step: float) -> Vector3:
	# approx slope in x and z directions using small step difference
	# slope along x and along z
	var normal = Vector3(
		(_get_height(x + step, z) - _get_height(x - step, z)) / (2.0 * step),
		1.0,
		(_get_height(x, z + step) - _get_height(x, z - step)) / (2.0 * step)
	)
	return normal.normalized()    # convert to unit vector for proper lighting

# generates grayscale heightmap image from the terrain heights
func _generate_heightmap_image() -> Image:
	var img := Image.create(rows, cols, false, Image.FORMAT_RF)    # single channel image (R only)
	for y in range(cols):
		for x in range(rows):
			var world_x = float(x) / rows * TERRAIN_SIZE
			var world_z = float(y) / cols * TERRAIN_SIZE
			var h = (_get_height(world_x, world_z) / hill_height + 1.0) * 0.5
			img.set_pixel(x, y, Color(h, h, h))
	return img

# main mesh building part 
 
# check if we have enough quads and a noise generator
func _build_terrain():
	if rows < 2 or cols < 2 or noise == null:
		return

# create a flat plane mesh with quads (or subdivisions)
	var plane := PlaneMesh.new()
	plane.size = Vector2(TERRAIN_SIZE, TERRAIN_SIZE)  # plane size
	# subdivisions/quads along x and z
	plane.subdivide_width = rows
	plane.subdivide_depth = cols

	# extract arrays from the mesh data to modify vertices
	var arrays = plane.get_mesh_arrays()
	var verts: PackedVector3Array = arrays[ArrayMesh.ARRAY_VERTEX]    # vertex positions 
	var norms: PackedVector3Array = arrays[ArrayMesh.ARRAY_NORMAL]     # vertex normals
	var tangents: PackedFloat32Array = arrays[ArrayMesh.ARRAY_TANGENT]    # tangents for lighting
	var uvs: PackedVector2Array = arrays[ArrayMesh.ARRAY_TEX_UV]      # texture coordinates

# step used for normal calculation
	var step = TERRAIN_SIZE / max(rows, cols)

	# loop through each vertex to update height and normal
	for i in verts.size():
		var v = verts[i]     # get vertex
		var u = uvs[i]       # get UV

		v.y = _get_height(v.x, v.z)    # set vertex height based on noise
		verts[i] = v     # update vertex array

		norms[i] = _get_normal(v.x, v.z, step)   # set correct normal for lighting

# calculate tangent vector for proper shading
		var tangent = norms[i].cross(Vector3.UP).normalized()
		tangents[4 * i] = tangent.x
		tangents[4 * i + 1] = tangent.y
		tangents[4 * i + 2] = tangent.z
		tangents[4 * i + 3] = 1.0

	# build final mesh from the modified arrays
	var final_mesh = ArrayMesh.new()
	final_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	mesh = final_mesh

	# generate and apply a heightmap texture
	# create texture from terrain heights
	var img = _generate_heightmap_image()
	heightmap = ImageTexture.create_from_image(img)
	if material_override:
		material_override.set_shader_parameter("albedo_texture", heightmap)
		# apply texture to material 
