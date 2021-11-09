//
//  RegisterModel.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/28.
//

import Foundation

struct Register: Codable {
    var status: Int
    var error: String?
    var message: String?
}

struct Getemail: Codable {
    var status: Int
    var error: String?
    var message: String?
}

struct Resend: Codable{
    var status: Int
    var error: String?
    var message: String?
}

struct LogIn: Codable {
    var status: Int
    var error: String?
    var message: String?
    var token: String?
}

struct ImagePost: Codable{
    var status: Int
    var message: String?
    var jsonUrl: [String]
}

struct Post: Codable{
    var status: Int
    var error: String?
    var message: String?
    var jsonUrl: [String]
}

// 메인 Feed 게시물 view정보
class Owner: Codable {
    var name: String
    var avatar: String
    var stuNumber: Int
    var classNumber: Int
    var grade: Int
    var permission: Int
    
    enum OwnerKeys: String, CodingKey {
        case name
        case avatar
        case stuNumber
        case classNumber
        case grade
        case permission
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OwnerKeys.self)
        
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.avatar = try container.decodeIfPresent(String.self, forKey: .avatar) ?? ""
        self.stuNumber = try container.decodeIfPresent(Int.self, forKey: .stuNumber) ?? 0
        self.classNumber = try container.decodeIfPresent(Int.self, forKey: .classNumber) ?? 0
        self.grade = try container.decodeIfPresent(Int.self, forKey: .grade) ?? 0
        self.permission = try container.decodeIfPresent(Int.self, forKey: .permission) ?? 0
    }
    
    internal init(name: String, avatar: String, stuNumber: Int, classNumber: Int, grade: Int, permission: Int) {
        self.name = name
        self.avatar = avatar
        self.stuNumber = stuNumber
        self.classNumber = classNumber
        self.grade = grade
        self.permission = permission
    }
}

struct Writings: Codable{
    var hashtags: [String?]
    var imgs: [String]
    var text: String?
    var _id: String
    var owner: Owner
    var isLike: Bool
    var likeCount: Int
}

struct HomeResponse: Codable{
    var writings: [Writings]
}

// 인기 게시물 View정보
class Owner2: Codable {
    var name: String
    var avatar: String
    var stuNumber: Int
    var classNumber: Int
    var grade: Int
    var permission: Int
    
    enum OwnerKeys: String, CodingKey {
        case name
        case avatar
        case stuNumber
        case classNumber
        case grade
        case permission
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OwnerKeys.self)
        
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.avatar = try container.decodeIfPresent(String.self, forKey: .avatar) ?? ""
        self.stuNumber = try container.decodeIfPresent(Int.self, forKey: .stuNumber) ?? 0
        self.classNumber = try container.decodeIfPresent(Int.self, forKey: .classNumber) ?? 0
        self.grade = try container.decodeIfPresent(Int.self, forKey: .grade) ?? 0
        self.permission = try container.decodeIfPresent(Int.self, forKey: .permission) ?? 0
    }
    
    internal init(name: String, avatar: String, stuNumber: Int, classNumber: Int, grade: Int, permission: Int) {
        self.name = name
        self.avatar = avatar
        self.stuNumber = stuNumber
        self.classNumber = classNumber
        self.grade = grade
        self.permission = permission
    }
}

struct Writings2: Codable{
    var hashtags: [String?]
    var imgs: [String]
    var text: String?
    var _id: String
    var owner: Owner2
    var isLike: Bool
    var likeCount: Int
}

struct Popular: Codable{
    var writings: [Writings2]
}

// userId

struct _id: Codable{
    var id: String
}

// 프로필View 정보

class PostInfo: Codable{
    var id: String
    var hashtags: [String]
    var likeCount: Int
    var comments: [String]
    var imgs: [String]
    var isLike: Bool
    var isOwner: Bool
    var text: String
    var owner: String
    
    enum PostInfoKeys: String, CodingKey {
        case id
        case hashtags
        case likeCount
        case comments
        case imgs
        case isLike
        case isOwner
        case text
        case owner
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PostInfoKeys.self)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.hashtags = try container.decodeIfPresent([String].self, forKey: .hashtags) ?? []
        self.likeCount = try container.decodeIfPresent(Int.self, forKey: .likeCount) ?? 0
        self.comments = try container.decodeIfPresent([String].self, forKey: .comments) ?? []
        self.imgs = try container.decodeIfPresent([String].self, forKey: .imgs) ?? []
        self.isLike = try container.decodeIfPresent(Bool.self, forKey: .isLike) ?? true
        self.isOwner = try container.decodeIfPresent(Bool.self, forKey: .isLike) ?? true
        self.text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""
        self.owner = try container.decodeIfPresent(String.self, forKey: .owner) ?? ""
    }
    internal init(id: String, hashtags: [String], likeCount: Int, comments: [String], imgs: [String], isLike: Bool, isOwner: Bool, text: String, owner: String) {
        self.id = id
        self.hashtags = hashtags
        self.likeCount = likeCount
        self.comments = comments
        self.imgs = imgs
        self.isLike = isLike
        self.isOwner = isOwner
        self.text = text
        self.owner = owner
    }
}

struct UserInfo: Codable{
    var _id: String = ""
    var isValid: Bool = false
    var writings: [PostInfo] = []
    var introduction: String = ""
    var avatar: String = ""
    var email: String = ""
    var password: String = ""
    var name: String = ""
    var grade: Int = 0
    var classNumber: Int = 0
    var stuNumber: Int = 0
    var permission: Int = 0
    
    enum UserInfoKeys: String, CodingKey {
        case _id
        case isValid
        case writings
        case introduction
        case avatar
        case email
        case password
        case name
        case grade
        case classNumber
        case stuNumber
        case permission
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserInfoKeys.self)
        
        self._id = try container.decodeIfPresent(String.self, forKey: ._id) ?? ""
        self.isValid = try container.decodeIfPresent(Bool.self, forKey: .isValid) ?? false
        self.writings = try container.decodeIfPresent([PostInfo].self, forKey: .writings) ?? []
        self.introduction = try container.decodeIfPresent(String.self, forKey: .introduction) ?? ""
        self.avatar = try container.decodeIfPresent(String.self, forKey: .avatar) ?? ""
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.password = try container.decodeIfPresent(String.self, forKey: .password) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.grade = try container.decodeIfPresent(Int.self, forKey: .grade) ?? 0
        self.classNumber = try container.decodeIfPresent(Int.self, forKey: .classNumber) ?? 0
        self.stuNumber = try container.decodeIfPresent(Int.self, forKey: .stuNumber) ?? 0
        self.permission = try container.decodeIfPresent(Int.self, forKey: .permission) ?? 0
    }
    internal init(_id: String = "", isValid: Bool = false, writings: [PostInfo] = [], introduction: String = "", avatar: String = "", email: String = "",password: String = "", name: String = "", grade: Int = 0, classNumber: Int = 0, stuNumber: Int = 0, permission: Int = 0) {
        self._id = _id
        self.isValid = isValid
        self.writings = writings
        self.introduction = introduction
        self.avatar = avatar
        self.email = email
        self.password = password
        self.name = name
        self.grade = grade
        self.classNumber = classNumber
        self.stuNumber = stuNumber
        self.permission = permission
    }
}
struct User: Codable{
    var user: UserInfo = UserInfo()
}

struct EditProfile: Codable{
    var status: Int
    var error: String?
    var message: String?
}

struct EditImage: Codable{
    var newavatar: String
    var error: String?
    var message: String?
    var status: Int
}
