// To parse this JSON data, do
//
//     final modelUser = modelUserFromJson(jsonString);

import 'dart:convert';

ModelUser modelUserFromJson(String str) => ModelUser.fromJson(json.decode(str));

String modelUserToJson(ModelUser data) => json.encode(data.toJson());

class ModelUser {
    final User? user;
    final List<String>? roles;
    final List<ModelUserPermission>? permissions;

    ModelUser({
        this.user,
        this.roles,
        this.permissions,
    });

    factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
        permissions: json["permissions"] == null ? [] : List<ModelUserPermission>.from(json["permissions"]!.map((x) => ModelUserPermission.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
        "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x.toJson())),
    };
}

class ModelUserPermission {
    final int? id;
    final String? name;
    final String? guardName;
    final String? createdAt;
    final String? updatedAt;
    final PurplePivot? pivot;

    ModelUserPermission({
        this.id,
        this.name,
        this.guardName,
        this.createdAt,
        this.updatedAt,
        this.pivot,
    });

    factory ModelUserPermission.fromJson(Map<String, dynamic> json) => ModelUserPermission(
        id: json["id"],
        name: json["name"],
        guardName: json["guard_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        pivot: json["pivot"] == null ? null : PurplePivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardName,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "pivot": pivot?.toJson(),
    };
}

class PurplePivot {
    final int? roleId;
    final int? permissionId;

    PurplePivot({
        this.roleId,
        this.permissionId,
    });

    factory PurplePivot.fromJson(Map<String, dynamic> json) => PurplePivot(
        roleId: json["role_id"],
        permissionId: json["permission_id"],
    );

    Map<String, dynamic> toJson() => {
        "role_id": roleId,
        "permission_id": permissionId,
    };
}

class User {
    final int? id;
    final String? email;
    final int? status;
    final DateTime? emailVerifiedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? idPegawai;
    final String? createdBy;
    final String? updatedBy;
    final bool? isDelete;
    final String? deletedAt;
    final String? deletedBy;
    final List<Role>? roles;
    final List<UserPermission>? permissions;
    final List<Session>? sessions;

    User({
        this.id,
        this.email,
        this.status,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.idPegawai,
        this.createdBy,
        this.updatedBy,
        this.isDelete,
        this.deletedAt,
        this.deletedBy,
        this.roles,
        this.permissions,
        this.sessions,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        status: json["status"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        idPegawai: json["id_pegawai"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        isDelete: json["is_delete"],
        deletedAt: json["deleted_at"],
        deletedBy: json["deleted_by"],
        roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
        permissions: json["permissions"] == null ? [] : List<UserPermission>.from(json["permissions"]!.map((x) => UserPermission.fromJson(x))),
        sessions: json["sessions"] == null ? [] : List<Session>.from(json["sessions"]!.map((x) => Session.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "status": status,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "id_pegawai": idPegawai,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "is_delete": isDelete,
        "deleted_at": deletedAt,
        "deleted_by": deletedBy,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
        "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x.toJson())),
        "sessions": sessions == null ? [] : List<dynamic>.from(sessions!.map((x) => x.toJson())),
    };
}

class UserPermission {
    final int? id;
    final String? name;
    final String? guardName;
    final String? createdAt;
    final String? updatedAt;
    final FluffyPivot? pivot;

    UserPermission({
        this.id,
        this.name,
        this.guardName,
        this.createdAt,
        this.updatedAt,
        this.pivot,
    });

    factory UserPermission.fromJson(Map<String, dynamic> json) => UserPermission(
        id: json["id"],
        name: json["name"],
        guardName: json["guard_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        pivot: json["pivot"] == null ? null : FluffyPivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardName,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "pivot": pivot?.toJson(),
    };
}

class FluffyPivot {
    final String? modelType;
    final int? modelId;
    final int? permissionId;

    FluffyPivot({
        this.modelType,
        this.modelId,
        this.permissionId,
    });

    factory FluffyPivot.fromJson(Map<String, dynamic> json) => FluffyPivot(
        modelType: json["model_type"],
        modelId: json["model_id"],
        permissionId: json["permission_id"],
    );

    Map<String, dynamic> toJson() => {
        "model_type": modelType,
        "model_id": modelId,
        "permission_id": permissionId,
    };
}

class Role {
    final int? id;
    final String? name;
    final String? guardName;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? createdBy;
    final String? updatedBy;
    final int? isDelete;
    final String? deletedAt;
    final String? deletedBy;
    final RolePivot? pivot;
    final List<ModelUserPermission>? permissions;

    Role({
        this.id,
        this.name,
        this.guardName,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.isDelete,
        this.deletedAt,
        this.deletedBy,
        this.pivot,
        this.permissions,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        guardName: json["guard_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        isDelete: json["is_delete"],
        deletedAt: json["deleted_at"],
        deletedBy: json["deleted_by"],
        pivot: json["pivot"] == null ? null : RolePivot.fromJson(json["pivot"]),
        permissions: json["permissions"] == null ? [] : List<ModelUserPermission>.from(json["permissions"]!.map((x) => ModelUserPermission.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "is_delete": isDelete,
        "deleted_at": deletedAt,
        "deleted_by": deletedBy,
        "pivot": pivot?.toJson(),
        "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x.toJson())),
    };
}

class RolePivot {
    final String? modelType;
    final int? modelId;
    final int? roleId;

    RolePivot({
        this.modelType,
        this.modelId,
        this.roleId,
    });

    factory RolePivot.fromJson(Map<String, dynamic> json) => RolePivot(
        modelType: json["model_type"],
        modelId: json["model_id"],
        roleId: json["role_id"],
    );

    Map<String, dynamic> toJson() => {
        "model_type": modelType,
        "model_id": modelId,
        "role_id": roleId,
    };
}

class Session {
    final String? id;
    final int? userId;
    final String? ipAddress;
    final String? userAgent;
    final String? payload;
    final int? lastActivity;

    Session({
        this.id,
        this.userId,
        this.ipAddress,
        this.userAgent,
        this.payload,
        this.lastActivity,
    });

    factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["id"],
        userId: json["user_id"],
        ipAddress: json["ip_address"],
        userAgent: json["user_agent"],
        payload: json["payload"],
        lastActivity: json["last_activity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "ip_address": ipAddress,
        "user_agent": userAgent,
        "payload": payload,
        "last_activity": lastActivity,
    };
}
