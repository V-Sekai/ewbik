# Copyright (c) 2018-present. This file is part of V-Sekai https://v-sekai.org/.
# K. S. Ernest (Fire) Lee & Contributors
# many_bone_ik_3d_gizmo_plugin.gd
# SPDX-License-Identifier: MIT

class ManyBoneIK3DGizmoPlugin : public EditorNode3DGizmoPlugin {
	GDCLASS(ManyBoneIK3DGizmoPlugin, EditorNode3DGizmoPlugin);
	Ref<Shader> kusudama_shader = memnew(Shader);

	Ref<StandardMaterial3D> unselected_mat;
	Ref<ShaderMaterial> selected_mat;
	Ref<Shader> selected_sh = memnew(Shader);

	MeshInstance3D *handles_mesh_instance = nullptr;
	Ref<ImmediateMesh> handles_mesh = memnew(ImmediateMesh);
	Ref<ShaderMaterial> handle_material = memnew(ShaderMaterial);
	Ref<Shader> handle_shader;
	ManyBoneIK3D *many_bone_ik = nullptr;
	Button *edit_mode_button = nullptr;
	bool edit_mode = false;

protected:
	static void _bind_methods();
	void _notifications(int32_t p_what);

public:
	const Color bone_color = EditorSettings::get_singleton()->get("editors/3d_gizmos/gizmo_colors/skeleton");
	const int32_t KUSUDAMA_MAX_CONES = 10;
	bool has_gizmo(Node3D *p_spatial) override;
	String get_gizmo_name() const override;
	void redraw(EditorNode3DGizmo *p_gizmo) override;
	ManyBoneIK3DGizmoPlugin();
	int32_t get_priority() const override;
	void create_gizmo_mesh(BoneId current_bone_idx, Ref<IKBone3D> ik_bone, EditorNode3DGizmo *p_gizmo, Color current_bone_color, Skeleton3D *many_bone_ik_skeleton, ManyBoneIK3D *p_many_bone_ik);
	int subgizmos_intersect_ray(const EditorNode3DGizmo *p_gizmo, Camera3D *p_camera, const Vector2 &p_point) const override;
	Transform3D get_subgizmo_transform(const EditorNode3DGizmo *p_gizmo, int p_id) const override;
	void set_subgizmo_transform(const EditorNode3DGizmo *p_gizmo, int p_id, Transform3D p_transform) override;
	void commit_subgizmos(const EditorNode3DGizmo *p_gizmo, const Vector<int> &p_ids, const Vector<Transform3D> &p_restore, bool p_cancel) override;

	void edit_mode_toggled(const bool pressed);
	void _subgizmo_selection_change();
	void _update_gizmo_visible();
	void _draw_gizmo();

	void _draw_handles();
	void _hide_handles();
};