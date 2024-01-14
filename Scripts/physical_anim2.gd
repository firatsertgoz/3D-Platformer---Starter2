extends Skeleton3D

@export var target_skeleton: Skeleton3D

@export var linear_spring_stiffness: float = 100.0
@export var linear_spring_damping: float = 10.0
@export var max_linear_force: float = 9999.0

@export var angular_spring_stiffness: float = 50.0
@export var angular_spring_damping: float = 20.0
@export var max_angular_force: float = 9999.0

@export var walk_speed: float = 1.0

var spine: PhysicalBone3D
var physics_bones
var target_skeleton_local
# Called when the node enters the scene tree for the first time.
func _ready():
	spine = get_node("Physical Bone Spine")
	physical_bones_start_simulation()
	physics_bones = get_children().filter(func(x): return x is PhysicalBone3D)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	walk()

func _physics_process(delta):
	pass
	#for b in physics_bones:
		#var target_transform: Transform3D = target_skeleton.global_transform * target_skeleton.get_bone_global_pose(b.get_bone_id())
		#var current_transform: Transform3D = global_transform * get_bone_global_pose(b.get_bone_id())
		#var rotation_difference: Basis = (target_transform.basis * current_transform.basis.inverse())
	#
		#var position_difference:Vector3 = target_transform.origin - current_transform.origin
		#
		#if position_difference.length_squared() > 1.0:
			#b.global_position = target_transform.origin
		#else:
			#var force: Vector3 = hookes_law(position_difference, b.linear_velocity, linear_spring_stiffness, linear_spring_damping)
			#force = force.limit_length(max_linear_force)
			#b.linear_velocity += (force * delta)
		#
		#var torque = hookes_law(rotation_difference.get_euler(), b.angular_velocity, angular_spring_stiffness, angular_spring_damping)
		#torque = torque.limit_length(max_angular_force)
		#
		#b.angular_velocity += torque * delta

func hookes_law(displacement: Vector3, current_velocity: Vector3, stiffness: float, damping: float) -> Vector3:
	return (stiffness * displacement) - (damping * current_velocity)

func walk():
	if Input.is_physical_key_pressed(KEY_W):
		spine.apply_central_impulse(-spine.basis.y * walk_speed)

	if Input.is_physical_key_pressed(KEY_S):
		spine.apply_central_impulse(spine.basis.y * walk_speed)
	
	if Input.is_physical_key_pressed(KEY_D):
		spine.apply_central_impulse(spine.basis.x * walk_speed)
		
	if Input.is_physical_key_pressed(KEY_A):
		spine.apply_central_impulse(-spine.basis.x * walk_speed)
